# Revisiting statistical methods for radiochromic film dosimetry — companion code

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/kmrakovcic/StatisticsRadiochromicFilmCalibration/blob/master/Revisiting_Statistical_Methods_for_Radiochromic_Film_Dosimetry.ipynb)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/kmrakovcic/StatisticsRadiochromicFilmCalibration/master?labpath=Revisiting_Statistical_Methods_for_Radiochromic_Film_Dosimetry.ipynb)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)

Reproducible companion notebook for the manuscript *“Revisiting statistical methods for
radiochromic film dosimetry.”* It regenerates **every figure in the paper** from scratch
with a deterministic Monte Carlo simulation of the calibration model

```
D = b * netOD + c * netOD^n        (paper Eq. 1)
```

and quantifies the impact of three statistical choices (paper Table 1):

| Axis | Recommended | Common mistake |
| --- | --- | --- |
| Objective function | `O1` — Eq. 2 (netOD is the noisy variable) | `O2` — Eq. 3 (netOD treated as exact) |
| Fitting procedure | `3-par.` — fit b, c, n jointly | `Fixed n` — assume n = 2.5 |
| Uncertainty propagation | `corr.` — Eq. 5 (full covariance) | `No corr.` — Eq. 7 (off-diagonals dropped) |

The notebook is meant to be read **alongside the paper**: each section cites the paper
section/equation it implements and interprets each figure against the manuscript's claims.

## Citation & license

- **Paper:** *Revisiting statistical methods for radiochromic film dosimetry.*
- **Authors:** Karlo Mrakovčić (first author, [ORCID 0009-0009-8154-3827](https://orcid.org/0009-0009-8154-3827))
  and Darko Mekterović (corresponding author, [ORCID 0000-0001-6220-5958](https://orcid.org/0000-0001-6220-5958)) —
  University of Rijeka, Faculty of Physics.
- **License:** GNU GPL v3 — see [`LICENSE`](LICENSE).

## Data availability

No external data. All datasets are **synthetic**, generated inside the notebook from the
calibration model with true parameters `b=5, c=35, n=2.5` and 1 % Gaussian noise on
netOD. With the fixed `SEED` in the setup cell, a single *Restart & Run All* regenerates
all data, figures and the summary table — nothing needs to be downloaded.

## Reproduce it

**Option A — Binder (zero install):** click the Binder badge above.

**Option B — conda (pinned):**

```bash
conda env create -f environment.yml
conda activate radiochromic-film
python -m ipykernel install --user --name radiochromic-film \
    --display-name "Python (radiochromic-film)"
jupyter notebook Revisiting_Statistical_Methods_for_Radiochromic_Film_Dosimetry.ipynb
```

**Option C — pip:** `pip install -r requirements.txt` (Python 3.11; needs system `zip`).

**Option D — Docker:** `docker build -t radiochromic-film . && docker run --rm -p 8888:8888 radiochromic-film`

Then **Kernel → Restart & Run All**. The fixed seed makes the run bit-for-bit
reproducible. Full run ≈ **30 min** (`QUICK_MODE = False`, 10 000 trials); set
`QUICK_MODE = True` in the setup cell for a ~1–2 min pass (1 000 trials, noisier but
qualitatively identical). The manuscript figures came from a different, unseeded
realization, so seeded figures are *statistically equivalent to*, not pixel-identical
to, the published ones.

## Outputs

* `Figures/` — one `.eps` and `.pdf` per panel; filenames match the manuscript `.tex`.
* `outputs/distribution_summary_statistics.csv` — per-distribution mean, std, sample
  count and scenario metadata for the parameter-estimate distributions (Figs 1–3).
* `Figures.zip` — bundled archive of all figures.

## Pinned environment

Python 3.11.15 · numpy 2.4.4 · scipy 1.17.1 · matplotlib 3.10.9 · pandas 3.0.3
(full pins in [`environment.yml`](environment.yml) / [`requirements.txt`](requirements.txt)).
The setup cell prints the live versions and the seed for provenance.
