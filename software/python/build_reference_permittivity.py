# =============================================================================
# build_reference_permittivity.py - builds data/reference-permittivity/ (the
# input folders of RDV-GUI-Compare_Permittivity_calc.vi) from article-data/:
# Compare/ = averaged DSS sweeps per liquid, Ideal/ = the R140/DAK reference
# resampled onto the DSS frequency grid, plus pairs.csv and a README.
# =============================================================================
"""Build the reference-permittivity comparison folders from the article data.

Usage (from the repository root, after unzipping article-data.zip):

    python software/python/build_reference_permittivity.py

Writes:
    data/reference-permittivity/Compare/P1_<liquid>.s2p   DSS (LibreVNA + probe P1), mean of all sweeps
    data/reference-permittivity/Ideal/<liquid>.s2p        R140 / DAKS-3.5, mean of the 3 buffers,
                                                          linearly resampled onto the DSS grid
    data/reference-permittivity/pairs.csv                 measured -> reference, only where the names differ
    data/reference-permittivity/README.md                 the naming rule

Both kinds of file use the repository's extended Touchstone columns
`Frequency S11_Real S11_Imag Perm_Real Perm_Imag Conductivity LossTan R X`.
The Ideal files carry no probe-P1 reflection, so their S11, R and X columns are 0.
The error analysis in LabVIEW subtracts point by point, so every file must have the
same frequency grid: the Ideal files are resampled onto the DSS grid for that reason.
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

# liquid on the DSS side -> R140 sample name (same name unless listed in PAIRS_OVERRIDE)
SAMPLES = {
    "session2": ["eth-12", "eth-24", "eth-33", "eth-48-2", "eth-66", "eth-96",
                 "iso-12", "iso-25", "iso-50", "iso-99"],
    "session3": ["adblue", "gaba-01", "gaba-05", "gaba-1", "saline", "saline-1-3"],
}
# eth-48-2 is the DSS remeasure of the eth-48 beaker (first DSS run had an air bubble);
# the R140 measured that beaker once, as eth-48.
PAIRS_OVERRIDE = {"eth-48-2": "eth-48"}

# calibration standards by ROLE (the LabVIEW methods index them as open 0, short 1, water 2, saline 6);
# simulated for probe P1 at 20 C, the temperature of the article liquids
STANDARDS = {
    "open": REPO / "data" / "calibration-standards" / "sim-P1-open.s2p",
    "short": REPO / "data" / "calibration-standards" / "sim-P1-short.s2p",
    "water": REPO / "data" / "calibration-standards" / "sim-P1-DI_water-20c.s2p",
    "saline": REPO / "data" / "calibration-standards" / "sim-P1-saltwater-20c.s2p",
}

PROBE = "P1"
EPS0 = 8.8541878128e-12
COLUMNS = ("Frequency", "S11_Real", "S11_Imag", "Perm_Real", "Perm_Imag",
           "Conductivity", "Loss Tangent", "Resistance", "Reactance")


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


def build(out: Path) -> list[tuple[str, str, str]]:
    (out / "Compare").mkdir(parents=True, exist_ok=True)
    (out / "Ideal").mkdir(parents=True, exist_ok=True)
    made = []
    for session, liquids in SAMPLES.items():
        for liquid in liquids:
            comments, dss, n_dss = mean_dss(DSS_ROOTS[session] / liquid)
            freq = dss[:, 0]
            measured = f"{PROBE}_{liquid}"
            keep = [c for c in comments if c.startswith(("! Probe", "! Since cal", "! Sweep", "! Method"))]
            write_s2p(out / "Compare" / f"{measured}.s2p",
                      [f"! Compare file built by build_reference_permittivity.py",
                       f"! Sample: {liquid}  ({session}, mean of {n_dss} DSS sweeps)", *keep],
                      dss)

            ref_name = PAIRS_OVERRIDE.get(liquid, liquid)
            r140, n_r140 = mean_r140(session, ref_name)
            if freq[0] < r140[0, 0] or freq[-1] > r140[-1, 0]:
                raise ValueError(f"{ref_name}: R140 range does not cover the DSS grid")
            e1 = np.interp(freq, r140[:, 0], r140[:, 1])
            e2 = np.interp(freq, r140[:, 0], r140[:, 2])
            sigma = 2 * np.pi * freq * EPS0 * e2
            tand = e2 / e1
            zeros = np.zeros_like(freq)
            ideal = np.column_stack([freq, zeros, zeros, e1, e2, sigma, tand, zeros, zeros])
            ideal_path = out / "Ideal" / f"{ref_name}.s2p"
            write_s2p(ideal_path,
                      [f"! Ideal (reference) file built by build_reference_permittivity.py",
                       f"! Sample: {ref_name}  ({session}, R140 / DAKS-3.5, mean of {n_r140} buffers)",
                       "! Resampled linearly onto the DSS frequency grid; S11, R and X are not measured (0)"],
                      ideal)
            made.append((measured, ref_name, session))
    build_standards(out, freq)
    return made


def build_standards(out: Path, grid: np.ndarray) -> None:
    """Resample the simulated standards onto the DSS grid, one file per role."""
    (out / "Standards").mkdir(parents=True, exist_ok=True)
    for role, src in STANDARDS.items():
        _, d = read_dss(src)
        cols = [grid] + [np.interp(grid, d[:, 0], d[:, c]) for c in range(1, d.shape[1])]
        write_s2p(out / "Standards" / f"{role}.s2p",
                  [f"! Calibration standard '{role}' built by build_reference_permittivity.py",
                   f"! Source: data/calibration-standards/{src.name} (CST simulation, probe P1)",
                   "! Resampled linearly onto the DSS frequency grid (0.2-6 GHz, 2071 points)"],
                  np.column_stack(cols))


README = """# reference-permittivity: input of RDV-GUI-Compare_Permittivity_calc.vi

Built by `software/python/build_reference_permittivity.py` from `article-data/`. Rebuild with that
script; do not edit the files by hand.

```
reference-permittivity/
├── Standards/   open, short, water, saline .s2p   calibration standards, chosen by NAME (role)
├── Compare/     <probe>_<liquid>.s2p   measured: DSS (LibreVNA + probe P1), mean of all sweeps
├── Ideal/       <liquid>.s2p           reference eps*: R140 / DAKS-3.5, mean of 3 buffers
└── pairs.csv    measured,reference     only for pairs whose liquid names differ
```

Standards are the simulated P1 standards from `data/calibration-standards/` at 20 C. The permittivity
methods need them in the order open, short, water, ..., saline (positions 0, 1, 2, 6); that order is
built from the file names, so the files need no number prefixes.

## Naming rule (what pairs a measurement with its reference)

1. A Compare file is `<probe>_<liquid>.s2p`; the probe is everything before the first `_`.
2. Its reference is `Ideal/<liquid>.s2p`, matched without regard to upper/lower case.
3. `pairs.csv` overrides rule 2 (`measured` = Compare file name without `.s2p`, `reference` =
   Ideal file name without `.s2p`).
4. A Compare file with no reference is reported as unpaired, never matched by position.

No number prefixes are needed and the order of the files does not matter.

## Grids and columns

Every file has the DSS grid (0.2-6 GHz, 2071 points): the error analysis subtracts point by point.
Columns: `Frequency S11_Real S11_Imag Perm_Real Perm_Imag Conductivity LossTan R X`,
`eps* = eps' - j*eps''` with `eps''` positive. Ideal files have S11, R and X = 0 (not measured
with probe P1).

## Sources

Day 1 (2026-10-31, `session2`): drift-corrected DSS sweeps. Day 2 (2026-11-01, `session3`): DSS sweeps
as recorded. `eth-48-2` is the DSS remeasure of the `eth-48` beaker (see `pairs.csv`). `saline` is the
0.9 % NaCl calibration standard and is included as an extra check. See `article-data/README.md`.
"""


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--out", type=Path, default=REPO / "data" / "reference-permittivity")
    args = ap.parse_args()
    made = build(args.out)
    with (args.out / "pairs.csv").open("w", newline="", encoding="utf-8") as fh:
        w = csv.writer(fh)
        w.writerow(["measured", "reference"])
        for measured, ref, _ in made:
            if measured.split("_", 1)[1].lower() != ref.lower():
                w.writerow([measured, ref])
    (args.out / "README.md").write_text(README, encoding="utf-8")
    for measured, ref, session in made:
        print(f"{session}  Compare/{measured}.s2p  <->  Ideal/{ref}.s2p")
    print(f"{len(made)} pairs -> {args.out}")


if __name__ == "__main__":
    main()
