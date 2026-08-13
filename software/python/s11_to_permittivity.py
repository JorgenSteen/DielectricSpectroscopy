"""Read the custom .s2p files and convert S11 to complex permittivity.

This is a minimal, NumPy-only reference implementation of the two things the
LabVIEW pipeline does: it reads the project's custom .s2p format, and it turns a
reflection coefficient (S11) into complex permittivity with the Bilinear method,
the extraction method the thesis settled on.

Custom .s2p format (comment lines start with '!', header line starts with '#'):

    Frequency  S11_Real  S11_Imag  Perm_Real  Perm_Imag  Conductivity  LossTan  R  X

Column 0 is frequency in Hz, columns 1-2 are the raw S11, and columns 3-4 are the
permittivity the pipeline already wrote (eps' and eps'', eps'' stored positive).
A plain 3-column Touchstone file (freq, S11_Real, S11_Imag) is read too; it just
has no stored permittivity.

Permittivity convention: eps* = eps' - j*eps'' (eps'' >= 0).
"""

import numpy as np

Z0 = 50.0  # reference impedance, ohms


def read_s2p(filepath):
    """Parse a custom .s2p file.

    Returns a dict with:
        freq       : (N,) frequency in Hz
        s11        : (N,) complex reflection coefficient
        perm       : (N,) complex permittivity already stored in the file,
                     or None if the file has no permittivity columns
    """
    freq, s11_re, s11_im = [], [], []
    eps_re, eps_im = [], []
    has_perm = True

    with open(filepath, "r") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("!") or line.startswith("#"):
                continue
            cols = line.split()
            freq.append(float(cols[0]))
            s11_re.append(float(cols[1]))
            s11_im.append(float(cols[2]))
            if len(cols) >= 5:
                eps_re.append(float(cols[3]))
                eps_im.append(float(cols[4]))
            else:
                has_perm = False

    perm = None
    if has_perm and eps_re:
        # stored eps'' is positive; internal convention is eps' - j*eps''
        perm = np.array(eps_re) - 1j * np.array(eps_im)

    return {
        "freq": np.array(freq),
        "s11": np.array(s11_re) + 1j * np.array(s11_im),
        "perm": perm,
    }


def solve_bilinear(gamma_standards, eps_standards):
    """Solve the Bilinear coefficients A, B, C at every frequency.

    The probe maps S11 to permittivity by a bilinear (Moebius) transform
    eps* = (A*Gamma + B) / (C*Gamma + 1). Three standards with known eps* fix
    the three complex unknowns at each frequency point.

    Parameters
    ----------
    gamma_standards : list of 3 arrays, each (N,) complex
        Measured S11 of the three calibration standards.
    eps_standards : list of 3 arrays, each (N,) complex
        Known permittivity of the three standards (eps' - j*eps'').

    Returns
    -------
    A, B, C : (N,) complex arrays
    cond : (N,) condition number of the 3x3 solve (watch for large values)
    """
    n = len(gamma_standards[0])
    A = np.zeros(n, dtype=complex)
    B = np.zeros(n, dtype=complex)
    C = np.zeros(n, dtype=complex)
    cond = np.zeros(n)

    for i in range(n):
        M = np.zeros((3, 3), dtype=complex)
        rhs = np.zeros(3, dtype=complex)
        for k in range(3):
            gk = gamma_standards[k][i]
            ek = eps_standards[k][i]
            M[k] = [gk, 1.0, -ek * gk]  # row: A*gk + B - C*ek*gk = ek
            rhs[k] = ek
        cond[i] = np.linalg.cond(M)
        A[i], B[i], C[i] = np.linalg.solve(M, rhs)

    return A, B, C, cond


def apply_bilinear(gamma, A, B, C):
    """Apply the Bilinear coefficients: eps* = (A*Gamma + B) / (C*Gamma + 1)."""
    return (A * gamma + B) / (C * gamma + 1)


def convert_s11_to_permittivity(gamma, cal_gamma, cal_eps):
    """One-shot Bilinear conversion of a measured S11 into permittivity.

    Parameters
    ----------
    gamma : (N,) complex
        Measured S11 of the unknown sample.
    cal_gamma : list of 3 arrays (N,) complex
        Measured S11 of the three calibration standards.
    cal_eps : list of 3 arrays (N,) complex
        Known permittivity of those three standards.

    Returns
    -------
    eps : (N,) complex permittivity of the sample (eps' - j*eps'')
    cond : (N,) condition number at each frequency
    """
    A, B, C, cond = solve_bilinear(cal_gamma, cal_eps)
    return apply_bilinear(gamma, A, B, C), cond


if __name__ == "__main__":
    import sys

    if len(sys.argv) != 2:
        print("Usage: python s11_to_permittivity.py <file.s2p>")
        print("Reads a custom .s2p file and prints its stored permittivity.")
        raise SystemExit(1)

    data = read_s2p(sys.argv[1])
    f = data["freq"]
    print(f"{len(f)} points, {f[0]/1e6:.1f} MHz to {f[-1]/1e9:.2f} GHz")
    if data["perm"] is not None:
        eps = data["perm"]
        print("freq[Hz]              S11                    eps'      eps''")
        for i in range(0, len(f), max(1, len(f) // 10)):
            print(f"{f[i]:.4e}  {data['s11'][i]: .4f}  "
                  f"{eps[i].real:8.3f}  {-eps[i].imag:8.3f}")
    else:
        print("No permittivity columns in this file (raw Touchstone).")
        print("Use convert_s11_to_permittivity() with three calibration standards.")
