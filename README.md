# RNA-seq Tutorial — Wilms Tumor Expression Analysis with limma

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ngsFC/RNAsequencing_tutorial/HEAD?urlpath=rstudio)

> A complete, step-by-step bulk RNA-seq analysis on a real pediatric cancer dataset (TARGET Wilms tumor): quality control on TPM data, differential expression with **limma** explained in detail (design matrices, contrasts, empirical Bayes, `treat`, `duplicateCorrelation`), and gene set analysis with **camera** and **GSEA**.

**Author:** Francesco Cecere (Senior Bioinformatic Researcher) · AORN Santobono-Pausilipon IRCCS

## Modules

Run them in order: Module 3 reads the results written by Module 2.

| File | Content |
|------|---------|
| `01_data_and_qc.Rmd` | TPM explained, combining tumors and normals, filtering, log2 transformation, PCA, sample-sample correlation, outliers |
| `02_differential_expression_limma.Rmd` | One linear model per gene, design matrix (`~ 0 + group`), contrasts (each histology vs normal, tumor vs normal, Unfavorable vs Favorable), `lmFit`, empirical Bayes (`eBayes`, limma-trend, `plotSA`), `decideTests`/`topTable`, Venn, MD and volcano plots, `treat()`, paired samples with `duplicateCorrelation()`, the p53 axis in anaplastic tumors |
| `03_gene_set_analysis.Rmd` | Competitive vs self-contained tests, `camera` (inter-gene correlation), pre-ranked GSEA with `fgsea`, method agreement, GO Biological Process with redundancy collapsing |

Pre-rendered reports are in `html/`; results tables in `results/`.

## Data

- **Source**: **TARGET-WT** (Wilms tumor), NCI TARGET program via the [GDC Data Portal](https://portal.gdc.cancer.gov/projects/TARGET-WT) — real RNA-seq (TPM), open-access.
- `data/TARGET_WT_gene_expression_tpm.csv` — 19,938 protein-coding genes × 124 tumors (82 Favorable / 42 Unfavorable histology).
- `data/sample_metadata.csv` — histology, age, sex, vital status of the tumors.
- `data/TARGET_WT_control_gene_expression_tpm.csv` / `TARGET_WT_control_clinical_raw.csv` — the same genes × the only 6 normal kidney samples that exist for this project (all from patients whose tumor is also included).
- `data/msigdb_hallmark.gmt`, `data/msigdb_go_bp.gmt` — MSigDB gene sets (CC BY 4.0).
- Built once by `data-prep/build_target_wt_data.R` and `data-prep/build_gene_sets.R` (not run by the tutorial — included for audit/rebuild).

A companion tutorial, **Exome_sequencing_tutorial**, analyzes the somatic mutations of the same TARGET-WT cohort: its TP53 findings are the mutational side of the p53 expression results in Module 2.

## Environment

Built by [repo2docker](https://repo2docker.readthedocs.io/) from `.binder/Dockerfile` (`FROM rocker/binder:4.4.1`), installing `tidyverse`, `plotly`, `DT`, `knitr`, `rmarkdown`, `pheatmap`, `ggrepel`, plus Bioconductor's `limma` and `fgsea`. No network access is needed at runtime.
