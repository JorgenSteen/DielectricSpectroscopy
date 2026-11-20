# =============================================================================
# Writes the independent Python reference for the Bilinear test (T3a): the
# permittivity of one measured .s2p from three standards, computed by
# software/python/s11_to_permittivity.py, one value per line for LabVIEW to read.
# =============================================================================
"""Usage (from the repo root, after unzipping data.zip):

    python software/labview/Tests/reference/make_bilinear_reference.py

Output: software/labview/Tests/reference/bilinear-ethanol48-22p5c.txt
Layout: N lines eps' (real part), then N lines eps'' (positive loss), %.17g each,
which is the order the Caraya test flattens `Common Format out` Permativity' and
Permativity'' in.
"""

import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, "..", "..", "..", ".."))
sys.path.insert(0, os.path.join(REPO, "software", "python"))

from s11_to_permittivity import read_s2p, convert_s11_to_permittivity  # noqa: E402

SAMPLE = "data/measurements/22p5c/aff/aff_22p5c_ethanol-48.s2p"
STANDARDS = [  # same order as the VI's inputs Open/Air, DI-Water, Salt Water
    "data/calibration-standards/sim-P1-open.s2p",
    "data/calibration-standards/sim-P1-DI_water-22p5c.s2p",
    "data/calibration-standards/sim-P1-saltwater-22p5c.s2p",
]
OUT = os.path.join(HERE, "bilinear-ethanol48-22p5c.txt")


def main():
    sample = read_s2p(os.path.join(REPO, SAMPLE))
    stds = [read_s2p(os.path.join(REPO, p)) for p in STANDARDS]
    for s in stds:
        if len(s["freq"]) != len(sample["freq"]) or (s["freq"] != sample["freq"]).any():
            raise SystemExit("frequency grids differ")
    eps, cond = convert_s11_to_permittivity(
        sample["s11"], [s["s11"] for s in stds], [s["perm"] for s in stds])
    with open(OUT, "w", newline="\n") as f:
        for v in eps.real:
            f.write("%.17g\n" % v)
        for v in -eps.imag:
            f.write("%.17g\n" % v)
    print("%d points, max cond %.3g, wrote %s" % (len(eps), cond.max(), OUT))


if __name__ == "__main__":
    main()
