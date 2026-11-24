# Software — minimal S11 → permittivity reference

`s11_to_permittivity.py` is a small, NumPy-only reference implementation of what the
LabVIEW pipeline does. It is not the full pipeline (that lives in the LabVIEW VIs); it
is a portable fallback so the file format and the extraction method are usable from any
Python install.

Two things it provides:

1. **A reader for the custom `.s2p` format** — `read_s2p(path)` returns frequency, complex
   S11, and the permittivity already stored in the file (columns 4-5). Plain 3-column
   Touchstone files are read too (they just have no stored permittivity).

2. **S11 → permittivity conversion** — `convert_s11_to_permittivity()` applies the
   Bilinear method (the extraction method the thesis settled on):
   `eps* = (A*Gamma + B) / (C*Gamma + 1)`, with A, B, C solved at each frequency from
   three calibration standards of known permittivity.

Permittivity convention throughout: `eps* = eps' - j*eps''`, with `eps''` stored positive.

## Usage

```bash
# inspect a file and print its stored permittivity
python s11_to_permittivity.py ../../data/calibration-standards/sim-P1-DI_water-25c.s2p
```

```python
from s11_to_permittivity import read_s2p, convert_s11_to_permittivity

sample = read_s2p("measurement.s2p")            # raw S11 of the unknown
opn    = read_s2p("open.s2p")                    # three standards, known eps*
water  = read_s2p("water.s2p")
salt   = read_s2p("saltwater.s2p")

eps, cond = convert_s11_to_permittivity(
    sample["s11"],
    [opn["s11"], water["s11"], salt["s11"]],
    [opn["perm"], water["perm"], salt["perm"]],  # or eps* from a reference model
)
```

Only dependency is NumPy.

## Building `data/reference-permittivity/`

`build_reference_permittivity.py` builds the input folders of the LabVIEW compare GUI
(`RDV-GUI-Compare_Permittivity_calc.vi`) from `article-data/` and `data/calibration-standards/`
(unzip both archives first):

```bash
python software/python/build_reference_permittivity.py              # -> data/reference-permittivity
python software/python/build_reference_permittivity.py --out <dir>  # somewhere else
```

- `Compare/P1_<liquid>.s2p`: the mean of all DSS sweeps of each article liquid (day 1 drift-corrected).
- `Ideal/NN-<name>.s2p`: the simulated P1 standards at 20 °C in the slots the LabVIEW methods read
  by position (00 open, 01 short, 02 water, 06 saline), and the R140 reference (mean of 3 buffers)
  of every liquid in the other slots.
- `association.txt` / `pairs.csv`: the GUI's "Association set" and the same pairs with names.

Everything is resampled onto the DSS grid (0.2–6 GHz, 2071 points), because the LabVIEW
calculations work point by point. The script never deletes or overwrites: it stops if `Ideal/` or
`Compare/` already exists, so hand-made changes in the git-ignored `data/` folder are safe.

## Note on calibration standards

The stored `Perm` columns of the open and short standard files are placeholders
(exactly `1 + 0j` and `-1 + 0j`), not physical permittivities. Feeding them directly
into `convert_s11_to_permittivity()` as the known eps* of the standards gives wrong
results. For real conversions, supply model-based eps* for each standard (e.g. a
Debye model for water, including the conductivity term for saline solutions) — the
same reference models the LabVIEW pipeline uses.
