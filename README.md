# Breedverse

<!-- badges: start -->
[![Development](https://img.shields.io/badge/development-active-blue.svg)](https://img.shields.io/badge/development-active-blue.svg)
![GitHub License](https://img.shields.io/github/license/Breeding-Insight/breedverse)

<!-- badges: end -->

**Breedverse** is a modular R Shiny application developed by [Breeding Insight](https://www.breedinginsight.org) at University of Florida (UF/IFAS). It serves as a unified hub that lets users install and launch specialized breeding analysis tools — all from a single interface, with no command-line setup required.

---

## Overview

Breedverse itself is a lightweight launcher. After installing it, users can install any combination of analysis modules directly from within the app. Each module unlocks a dedicated section in the sidebar with its own set of analysis tools.

---

## Installation

Install Breedverse from GitHub using `remotes`:

```r
# install.packages("remotes")
remotes::install_github("Breeding-Insight/Breedverse")
```

Then launch the app:

```r
Breedverse::run_app()
```

---

## Modules

Modules are installed from within the app via the **Install Modules** page. Each module is sourced from GitHub and loaded dynamically. A restart of the app is required after installation to activate the new features.

### Qploidy — Ploidy Estimation

> GitHub: [`Cristianetaniguti/Qploidy`](https://github.com/Cristianetaniguti/Qploidy)

| Feature | Description |
|---|---|
| Standardization | Allele intensities / read counts standardization |
| Ploidy Estimation | Sample-level ploidy inference |
| Aneuploidy Detection | Identify chromosomal copy-number aberrations |

---

### BIGapp — Genotype Processing, Population Genomics, GWAS and GS

> GitHub: [`Breeding-Insight/BIGapp`](https://github.com/Breeding-Insight/BIGapp)

| Category | Feature |
|---|---|
| Genotype Processing | Convert dosage files to VCF |
| Dosage Calling | Off-target SNP calling with updog |
| Filtering | VCF quality filtering |
| Summary Metrics | Genomic diversity statistics |
| Population Structure | PCA, DAPC |
| GWAS | Genome-Wide Association Studies |
| Genomic Selection | GS model fitting and prediction |

---

### Familia — Ancestry Estimation

> GitHub: [`Breeding-Insight/familia`](https://github.com/Breeding-Insight/familia)

| Mode | Feature |
|---|---|
| Unsupervised | SNMF — ADMIXTURE-like ancestry proportions |
| Supervised | PolyBreedTools — reference-panel-based ancestry assignment |
| Ploidy Support | Compatible with diploid and polyploid species |

---

### AlloMate — Optimized Mating Plans

> GitHub: [`Breeding-Insight/AlloMate`](https://github.com/Breeding-Insight/AlloMate)

| Feature | Description |
|---|---|
| Relatedness | Evaluate genetic relatedness among breeding candidates |
| Multi-trait Index | Combine EBVs across traits using user-defined weights |
| OCS | Optimum Contribution Selection to maximize genetic gain |
| Mating Plans | Generate feasible mating lists under kinship constraints |

---

## Requirements

- R ≥ 3.6.0
- Internet connection for module installation (modules are pulled from GitHub)

---

## About Breeding Insight

- Website: https://www.breedinginsight.org
- Contact: https://breedinginsight.org/contact-us/


