# RNA-seq Tutorial — Wilms Tumor Expression Analysis with limma

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ngsFC/RNAsequencing_tutorial/HEAD?urlpath=rstudio)

> A complete, step-by-step bulk RNA-seq analysis on a real pediatric cancer dataset (TARGET Wilms tumor): 6 tumors and the normal kidneys of the same 6 children. Quality control on TPM data, differential expression with **limma** explained in detail (design matrices, contrasts, empirical Bayes, paired designs, `treat`), and gene set analysis with **camera** and **GSEA**. The whole tutorial runs in under a minute.

**Author:** Francesco Cecere (Senior Bioinformatic Researcher) · AORN Santobono-Pausilipon IRCCS

## Modules

Run them in order: Module 3 reads the results written by Module 2.

| File | Content |
|------|---------|
| `01_data_and_qc.Rmd` | TPM explained, combining tumors and normals into a paired sample sheet, filtering, log2 transformation, PCA with patient pairs, sample-sample correlation |
| `02_differential_expression_limma.Rmd` | One linear model per gene, design matrix (`~ 0 + condition`), contrasts, `lmFit`, empirical Bayes (`eBayes`, limma-trend, `plotSA`, moderated vs ordinary t), `decideTests`/`topTable`, the paired model `~ patient + condition` (and `duplicateCorrelation()` as the alternative), `treat()`, MD and volcano plots, per-child gene plots, heatmap |
| `03_gene_set_analysis.Rmd` | Competitive vs self-contained tests, `camera` (inter-gene correlation), pre-ranked GSEA with `fgsea`, method agreement, GO Biological Process with redundancy collapsing |

Pre-rendered reports are in `html/`; results tables in `results/`.

## Data

- **Source**: **TARGET-WT** (Wilms tumor), NCI TARGET program via the [GDC Data Portal](https://portal.gdc.cancer.gov/projects/TARGET-WT) — real RNA-seq (TPM), open-access.
- `data/TARGET_WT_control_gene_expression_tpm.csv` / `TARGET_WT_control_clinical_raw.csv` — 19,938 protein-coding genes × the only 6 normal kidney samples that exist for this project.
- `data/TARGET_WT_gene_expression_tpm.csv` — the same genes × the tumors of the same 6 children (all Favorable histology).
- `data/sample_metadata.csv` — age, sex, vital status of the 6 children.
- `data/msigdb_hallmark.gmt`, `data/msigdb_go_bp.gmt` — MSigDB gene sets (CC BY 4.0).
- Built once by `data-prep/build_target_wt_data.R` (all 124 TARGET-WT tumors + 6 normals), then `data-prep/build_paired_subset.R` (keeps the 6 tumor–normal pairs), and `data-prep/build_gene_sets.R` (not run by the tutorial — included for audit/rebuild).

A companion tutorial, **Exome_sequencing_tutorial**, analyzes the somatic mutations of TARGET-WT tumors. One child, TARGET-50-CAAAAR, is in both: its tumor carries a WT1 driver mutation.

## Environment

Built by [repo2docker](https://repo2docker.readthedocs.io/) from `.binder/Dockerfile` (`FROM rocker/binder:4.4.1`), installing `tidyverse`, `plotly`, `DT`, `knitr`, `rmarkdown`, `pheatmap`, `ggrepel`, plus Bioconductor's `limma` and `fgsea`. No network access is needed at runtime.
