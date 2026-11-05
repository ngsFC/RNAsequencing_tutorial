# Restricts the tumors in data/ to the 6 patients that also have a normal
# kidney sample, so that the tutorial analyzes 6 tumor-normal PAIRS.
#
# Run AFTER build_target_wt_data.R, from the root of this repository. Like the
# other data-prep scripts, it is NOT run during the tutorial.
#
# Requires: tidyverse.

library(tidyverse)

control_metadata <- read_csv("data/TARGET_WT_control_clinical_raw.csv", show_col_types = FALSE)

sample_metadata <- read_csv("data/sample_metadata.csv", show_col_types = FALSE) %>%
  filter(case_submitter_id %in% control_metadata$case_submitter_id)

tumor_tpm <- read_csv("data/TARGET_WT_gene_expression_tpm.csv", show_col_types = FALSE) %>%
  select(gene_name, all_of(sample_metadata$case_submitter_id))

# Every normal sample must have its patient's tumor, and vice versa.
stopifnot(setequal(sample_metadata$case_submitter_id, control_metadata$case_submitter_id),
          identical(colnames(tumor_tpm)[-1], sample_metadata$case_submitter_id))

write_csv(tumor_tpm, "data/TARGET_WT_gene_expression_tpm.csv")
write_csv(sample_metadata, "data/sample_metadata.csv")
cat("Kept", nrow(sample_metadata), "tumors, one per normal kidney sample\n")
