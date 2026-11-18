

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
- `article-data.zip` — the data of the JoEB article (2026), zipped; see [Article data](#article-data-2026)

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

## Article data (2026)

`article-data.zip` holds the data behind the article *Affordable microwave dielectric
spectroscopy system* (Journal of Electrical Bioimpedance). Twelve liquids were measured
back-to-back on the affordable system (LibreVNA + probe P1, newer DSS software) and on the
reference (SPEAG DAKS-3.5 on an R140 reflectometer), from the same beaker, at 20 °C:

- day 1 (2026-10-31, probe through a 1.83 m cable): ethanol–water 48/24/12 % and
  isopropanol–water 99/50/25/12 %
- day 2 (2026-11-01, probe directly on the LibreVNA port): diluted saline, AdBlue and
  GABA 0.1/0.5/1 mol/kg

Unzip it in the repository root; it creates `article-data/`:

```
article-data/
├── README.md                         full description: samples, layout, formats, standards
├── DSS_LibreVNA/                     DSS sweeps as written by the software (S11 + permittivity)
├── DSS_LibreVNA_drift-corrected/     day 1 after the software's drift correction
├── R140_raw/                         reference exports from the DAK software (.xlsx)
├── R140_csv/                         the same reference data as CSV, with index.csv
└── standards/                        measured 96 % ethanol standard (4-standard method)
```

The DSS files use the `.s2p` format above. The simulated open, short, water and saltwater
standards at 20 °C are the ones in `data.zip` (`data/calibration-standards/`).

## Starting Point
Opening the vi called RDV-GUI-SinglePlot would be a good point inside relfection data viewer class, GUI and Testers