# Dielectric Spectroscopy

Data and tools from my master thesis on open-ended coaxial probe (OECP) dielectric
spectroscopy: measuring the complex permittivity of liquids from S11 reflection
measurements, 100 MHz – 6 GHz.

## Repository layout

- `hardware/` — probe design files
  - `probe/` — full OECP schematic (PDF) and probe model image
  - `3D files/` — printable parts for the measurement stand and probe holder (.3mf, .step)
- `software/`
  - `python/` — minimal NumPy-only reference implementation: reader for the custom
    `.s2p` format and S11 → permittivity conversion via the Bilinear method
    (see its own README)
  - `labview/` — the full LabVIEW measurement/processing pipeline
- `data.zip` — all measurement data, zipped
- `data/` — the unzipped data (this folder itself is not tracked in git, see below)

## Data

The measurement data ships as `data.zip`. Unzip it in the repository root so it
creates the `data/` folder:

```
data/
├── calibration-standards/        simulated standards: open, short, DI water and
│                                 saltwater at 10–40 °C  (sim-P1-*.s2p)
└── measurements/
    ├── 10c/                      measurements at 10 °C
    │   ├── aff/                  affected probe   (aff_10c_<sample>.s2p)
    │   └── ref/                  reference probe  (ref_10c_<sample>.s2p)
    ├── 22p5c/                    measurements at 22.5 °C
    │   ├── aff/
    │   └── ref/
    └── 35c/                      measurements at 35 °C
        ├── aff/
        └── ref/
```

Samples include water, saltwater, ethanol, isopropanol, AdBlue and GABA solutions,
plus open/short/water checks taken at the start, middle and end of each session.

## Data format

The `.s2p` files use a custom extended Touchstone format: comment lines start with
`!`, the header line starts with `#`, and each data row is

```
Frequency  S11_Real  S11_Imag  Perm_Real  Perm_Imag  Conductivity  LossTan  R  X
```

Permittivity convention: `eps* = eps' - j*eps''` with `eps''` stored positive.
See `software/python/README.md` for a reader and conversion reference.
