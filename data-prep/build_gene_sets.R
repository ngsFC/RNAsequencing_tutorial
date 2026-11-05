# Builds the two gene-set files under data/ from MSigDB (via the msigdbr package),
# used by Module 3. Like build_geo_data.R, it was run once so that the tutorial
# needs no download at runtime.
#
# MSigDB Hallmark and GO collections are distributed under CC BY 4.0:
# Liberzon et al., Cell Systems 2015; https://www.gsea-msigdb.org
#
# Requires: tidyverse, msigdbr.

library(tidyverse)
library(msigdbr)

# One line per gene set: name, description (here the MSigDB version), genes.
write_gmt <- function(gene_sets, path) {
  gene_sets %>%
    distinct(gs_name, gene_symbol) %>%
    group_by(gs_name) %>%
    summarise(line = paste(c(first(gs_name), "MSigDB", gene_symbol), collapse = "\t"), .groups = "drop") %>%
    pull(line) %>%
    write_lines(path)
}

write_gmt(msigdbr(species = "Homo sapiens", collection = "H"), "data/msigdb_hallmark.gmt")
write_gmt(msigdbr(species = "Homo sapiens", collection = "C5", subcollection = "GO:BP"), "data/msigdb_go_bp.gmt")
cat("Wrote data/msigdb_hallmark.gmt and data/msigdb_go_bp.gmt (msigdbr", as.character(packageVersion("msigdbr")), ")\n")
