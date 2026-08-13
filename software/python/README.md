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

## Note on calibration standards

The stored `Perm` columns of the open and short standard files are placeholders
(exactly `1 + 0j` and `-1 + 0j`), not physical permittivities. Feeding them directly
into `convert_s11_to_permittivity()` as the known eps* of the standards gives wrong
results. For real conversions, supply model-based eps* for each standard (e.g. a
Debye model for water, including the conductivity term for saline solutions) — the
same reference models the LabVIEW pipeline uses.
