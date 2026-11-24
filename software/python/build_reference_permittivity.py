# =============================================================================
# build_reference_permittivity.py - builds data/reference-permittivity/ (the
# input folders of RDV-GUI-Compare_Permittivity_calc.vi) from article-data/:
# Ideal/ = numbered calibration standards + R140 references, Compare/ =
# averaged DSS sweeps, all on the DSS grid, plus the GUI's Association set.
# =============================================================================
"""Build the reference-permittivity comparison folders from the article data.

Usage (from the repository root, after unzipping article-data.zip and data.zip):

    python software/python/build_reference_permittivity.py

Writes data/reference-permittivity/:
    Ideal/NN-<name>.s2p      the GUI's "reference paths" folder: calibration standards at the
                             positions the permittivity methods use (00 open, 01 short,
                             02 water, 06 saline) and the R140 / DAKS-3.5 reference of every
                             liquid in the other slots (mean of 3 buffers)
    Compare/P1_<liquid>.s2p  the GUI's "Files for analyses" folder: DSS (LibreVNA + probe P1),
                             mean of all sweeps
    association.txt          the GUI's "Association set" ([reference index, set index] pairs)
    pairs.csv                measured file, reference file, both indices (human-readable)
    README.md                the naming rule

The current LabVIEW code finds everything by SORTED POSITION, which is why the Ideal files are
numbered with two digits (the number fixes the position; two digits keep 10+ in order).
All files use the repository's extended Touchstone columns
`Frequency S11_Real S11_Imag Perm_Real Perm_Imag Conductivity LossTan R X`, and all are on the
DSS frequency grid, because the LabVIEW calculations work point by point.
"""

from __future__ import annotations

import argparse
import csv
from pathlib import Path

import numpy as np

REPO = Path(__file__).resolve().parents[2]
ART = REPO / "article-data"
DSS_ROOTS = {
    # day 1: drift-corrected sweeps (the article's choice), day 2: as recorded
    "session2": ART / "DSS_LibreVNA_drift-corrected" / "session2_cal-20C",
    "session3": ART / "DSS_LibreVNA" / "session3_2026-11-01_nocable_cal-20C",
}
R140_ROOT = ART / "R140_csv"
CAL = REPO / "data" / "calibration-standards"

# sample folder name in article-data, per session
SAMPLES = {
    "session2": ["eth-12", "eth-24", "eth-33", "eth-48-2", "eth-66", "eth-96",
                 "iso-12", "iso-25", "iso-50", "iso-99"],
    "session3": ["adblue", "gaba-01", "gaba-05", "gaba-1", "saline", "saline-1-3"],
}
# R140 sample measured for a DSS sample when the names differ: eth-48-2 is the DSS remeasure of the
# eth-48 beaker (the first DSS run had an air bubble); the R140 measured that beaker once, as eth-48.
R140_NAME = {"eth-48-2": "eth-48"}
# names used in the output. 'saline' (0.9 % NaCl) is renamed: its keys would otherwise interleave
# with 'saline-1-3' in the sorted key list (P1_saline-1 < P1_saline-1-3-0 < P1_saline-2), and the
# GUI groups the four method keys of a set by position.
OUT_NAME = {"saline": "saline-0p9", "eth-48": "eth-48"}

# calibration standards and the slot each one must occupy (RDC-permittivity_collection and the
# method VIs index the reference list: open 0, short 1, water 2, saline 6); simulated for probe P1
# at 20 C, the temperature of the article liquids
STANDARD_SLOTS = {
    0: ("open", CAL / "sim-P1-open.s2p"),
    1: ("short", CAL / "sim-P1-short.s2p"),
    2: ("water", CAL / "sim-P1-DI_water-20c.s2p"),
    6: ("saline", CAL / "sim-P1-saltwater-20c.s2p"),
}

PROBE = "P1"
EPS0 = 8.8541878128e-12
COLUMNS = ("Frequency", "S11_Real", "S11_Imag", "Perm_Real", "Perm_Imag",
           "Conductivity", "Loss Tangent", "Resistance", "Reactance")
METHOD_SUFFIXES = ("0", "1", "2", "3")  # the GUI loads each Compare file once per method


def read_dss(path: Path) -> tuple[list[str], np.ndarray]:
    """Return the '!' comment lines and the numeric rows of one DSS .s2p file."""
    comments, rows = [], []
    for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        s = line.strip()
        if not s:
            continue
        if s.startswith("!"):
            comments.append(s)
        elif not s.startswith("#"):
            rows.append([float(v) for v in s.split()])
    return comments, np.asarray(rows)


def mean_dss(folder: Path) -> tuple[list[str], np.ndarray, int]:
    files = sorted(folder.glob("*.s2p"))
    if not files:
        raise FileNotFoundError(f"no .s2p in {folder}")
    comments, first = read_dss(files[0])
    stack = [first]
    for f in files[1:]:
        _, d = read_dss(f)
        if d.shape != first.shape or not np.array_equal(d[:, 0], first[:, 0]):
            raise ValueError(f"{f}: frequency grid differs from {files[0]}")
        stack.append(d)
    return comments, np.mean(stack, axis=0), len(files)


def read_r140(path: Path) -> np.ndarray:
    rows = []
    with path.open(newline="", encoding="utf-8") as fh:
        reader = csv.reader(line for line in fh if not line.startswith("#"))
        header = next(reader)
        idx = {name: i for i, name in enumerate(header)}
        for r in reader:
            rows.append([float(r[idx["freq_hz"]]), float(r[idx["eps_real"]]), float(r[idx["eps_imag"]])])
    return np.asarray(rows)


def mean_r140(session: str, sample: str) -> tuple[np.ndarray, int]:
    files = sorted((R140_ROOT / session).glob(f"{sample}_b[0-9].csv"))
    if not files:
        raise FileNotFoundError(f"no R140 buffers for {session}/{sample}")
    stack = [read_r140(f) for f in files]
    return np.mean(stack, axis=0), len(files)


def write_s2p(path: Path, comments: list[str], data: np.ndarray) -> None:
    lines = [*comments,
             "! S-Parameter data: F S11 e",
             "!" + "".join(f"{c:>20}" for c in COLUMNS),
             "# Hz S RI R 50"]
    lines += ["      ".join(f"{v:.12E}" for v in row) for row in data]
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def resample(grid: np.ndarray, data: np.ndarray) -> np.ndarray:
    return np.column_stack([grid] + [np.interp(grid, data[:, 0], data[:, c]) for c in range(1, data.shape[1])])


def build(out: Path) -> tuple[list[dict], list[tuple[int, str]]]:
    # never delete or overwrite: the folders may hold hand-made changes (git does not track data/)
    for sub in ("Ideal", "Compare"):
        if (out / sub).exists():
            raise SystemExit(f"{out / sub} already exists: move it away or pass --out to a new folder. "
                             "This script never deletes or overwrites files.")
    (out / "Ideal").mkdir(parents=True)
    (out / "Compare").mkdir(parents=True)

    pairs, refs, grid = [], {}, None
    for session, samples in SAMPLES.items():
        for sample in samples:
            comments, dss, n_dss = mean_dss(DSS_ROOTS[session] / sample)
            if grid is None:
                grid = dss[:, 0]
            elif not np.array_equal(grid, dss[:, 0]):
                raise ValueError(f"{sample}: DSS grid differs from the first sample")
            liquid = OUT_NAME.get(sample, sample)
            measured = f"{PROBE}_{liquid}"
            keep = [c for c in comments if c.startswith(("! Probe", "! Since cal", "! Sweep", "! Method"))]
            write_s2p(out / "Compare" / f"{measured}.s2p",
                      ["! Compare file built by build_reference_permittivity.py",
                       f"! Sample: {sample}  ({session}, mean of {n_dss} DSS sweeps)", *keep],
                      dss)

            r140_sample = R140_NAME.get(sample, sample)
            r140, n_r140 = mean_r140(session, r140_sample)
            if grid[0] < r140[0, 0] or grid[-1] > r140[-1, 0]:
                raise ValueError(f"{r140_sample}: R140 range does not cover the DSS grid")
            e1 = np.interp(grid, r140[:, 0], r140[:, 1])
            e2 = np.interp(grid, r140[:, 0], r140[:, 2])
            zeros = np.zeros_like(grid)
            ref_name = OUT_NAME.get(r140_sample, r140_sample)
            refs[ref_name] = (
                [f"! Reference built by build_reference_permittivity.py",
                 f"! Sample: {r140_sample}  ({session}, R140 / DAKS-3.5, mean of {n_r140} buffers)",
                 "! Resampled linearly onto the DSS grid; S11, R and X are not measured with probe P1 (0)"],
                np.column_stack([grid, zeros, zeros, e1, e2, 2 * np.pi * grid * EPS0 * e2, e2 / e1, zeros, zeros]))
            pairs.append({"measured": measured, "reference": ref_name, "session": session})

    # slots: standards at their fixed positions, the liquids (alphabetical) in the free ones
    n = len(STANDARD_SLOTS) + len(refs)
    free = [i for i in range(n) if i not in STANDARD_SLOTS]
    slots: dict[int, str] = {}
    for i, (role, src) in STANDARD_SLOTS.items():
        _, d = read_dss(src)
        write_s2p(out / "Ideal" / f"{i:02d}-{role}.s2p",
                  [f"! Calibration standard '{role}' (slot {i}) built by build_reference_permittivity.py",
                   f"! Source: data/calibration-standards/{src.name} (CST simulation, probe P1)",
                   "! Resampled linearly onto the DSS frequency grid"],
                  resample(grid, d))
        slots[i] = role
    for i, name in zip(free, sorted(refs)):
        comments, data = refs[name]
        write_s2p(out / "Ideal" / f"{i:02d}-{name}.s2p", comments, data)
        slots[i] = name

    # indices exactly as the GUI computes them: references in sorted order of their keys, sets in
    # sorted order of the Compare keys (each set = its 4 method keys)
    ref_keys = sorted(f"{i:02d}-{name}-r" for i, name in slots.items())
    ref_index = {k.rsplit("-", 1)[0].split("-", 1)[1]: j for j, k in enumerate(ref_keys)}
    compare_keys = sorted(f"{p['measured']}-{m}" for p in pairs for m in METHOD_SUFFIXES)
    sets = [k.rsplit("-", 1)[0] for k in compare_keys[::len(METHOD_SUFFIXES)]]
    for start, s in zip(range(0, len(compare_keys), len(METHOD_SUFFIXES)), sets):
        group = compare_keys[start:start + len(METHOD_SUFFIXES)]
        if any(k.rsplit("-", 1)[0] != s for k in group):
            raise ValueError(f"method keys of '{s}' are not contiguous after sorting: {group}")
    for p in pairs:
        p["ref_index"] = ref_index[p["reference"]]
        p["set_index"] = sets.index(p["measured"])
    return pairs, sorted(slots.items())


def write_readme(out: Path, slots: list[tuple[int, str]]) -> None:
    table = "\n".join(f"| {i:02d} | `{i:02d}-{name}.s2p` | "
                      f"{'calibration standard (simulated P1, 20 C)' if i in STANDARD_SLOTS else 'R140 reference'} |"
                      for i, name in slots)
    (out / "README.md").write_text(f"""# reference-permittivity: input of RDV-GUI-Compare_Permittivity_calc.vi

Built by `software/python/build_reference_permittivity.py` from `article-data/` and
`data/calibration-standards/`. Rebuild with that script; do not edit the files by hand.

```
reference-permittivity/
├── Ideal/            NN-<name>.s2p         GUI control "reference paths"
├── Compare/          P1_<liquid>.s2p       GUI control "Files for analyses"
├── association.txt   GUI control "Association set" (paste the line in)
└── pairs.csv         the same pairs, readable: measured, reference, indices
```

## Why the numbers

The GUI sorts every key alphabetically and finds files by POSITION in that list:
- the first N keys (N = number of Ideal files) are the references; the permittivity methods take the
  calibration standards from them by fixed position: **open 00, short 01, water 02, saline 06**;
- the rest are the Compare files, four keys each (one per calculation method);
- the "Association set" pairs a reference index with a set index.

So the Ideal files carry a two-digit number (two digits keep 10+ files in order), the standards sit in
their fixed slots, and every Compare file name must sort after the numbers (it starts with a letter).

| Slot | File | What |
|---|---|---|
{table}

## Rules when adding files

1. Ideal: next free two-digit number, `NN-<name>.s2p`; never move 00, 01, 02, 06.
2. Compare: `<probe>_<liquid>.s2p`, starting with a letter. No liquid name may be another liquid name
   followed by `-<digit>` (for example `saline` and `saline-1-3`): their method keys would interleave.
3. Rerun the script (or recount by hand) and paste the new `association.txt` into the GUI.

## Grids and columns

Every file has the DSS grid (0.2-6 GHz, 2071 points): the LabVIEW calculations work point by point.
Columns: `Frequency S11_Real S11_Imag Perm_Real Perm_Imag Conductivity LossTan R X`,
`eps* = eps' - j*eps''` with `eps''` positive. R140 references have S11, R and X = 0 (not measured
with probe P1).

## Sources

Day 1 (2026-10-31): drift-corrected DSS sweeps; day 2 (2026-11-01): DSS sweeps as recorded.
`P1_eth-48-2` is the DSS remeasure of the `eth-48` beaker. `saline-0p9` is the 0.9 % NaCl liquid
(article folder `saline`), renamed so it cannot interleave with `saline-1-3`. See `article-data/README.md`.
""", encoding="utf-8")


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--out", type=Path, default=REPO / "data" / "reference-permittivity")
    args = ap.parse_args()
    pairs, slots = build(args.out)
    pairs.sort(key=lambda p: p["set_index"])
    with (args.out / "pairs.csv").open("w", newline="", encoding="utf-8") as fh:
        w = csv.writer(fh)
        w.writerow(["measured", "reference", "reference_index", "set_index", "session"])
        for p in pairs:
            w.writerow([p["measured"], p["reference"], p["ref_index"], p["set_index"], p["session"]])
    assoc = "[" + ",".join(f"[{p['ref_index']},{p['set_index']}]" for p in pairs) + "]"
    (args.out / "association.txt").write_text(assoc + "\n", encoding="utf-8")
    write_readme(args.out, slots)
    for i, name in slots:
        print(f"Ideal/{i:02d}-{name}.s2p")
    for p in pairs:
        print(f"set {p['set_index']:2d}  Compare/{p['measured']}.s2p  <->  reference {p['ref_index']:2d} ({p['reference']})")
    print("Association set:", assoc)


if __name__ == "__main__":
    main()
