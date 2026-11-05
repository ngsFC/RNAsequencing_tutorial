FROM rocker/binder:4.4.1
LABEL maintainer='Francesco Cecere'
COPY --chown=${NB_USER} . ${HOME}
USER ${NB_USER}

RUN R -e "options(repos = list(CRAN = 'https://packagemanager.posit.co/cran/__linux__/jammy/latest')); \
          pkgs <- c('tidyverse', 'plotly', 'DT', 'BiocManager', 'knitr', 'rmarkdown', 'pheatmap', 'ggrepel'); \
          install.packages(pkgs); \
          BiocManager::install(c('limma', 'fgsea'), update = FALSE, ask = FALSE); \
          all_pkgs <- c(pkgs, 'limma', 'fgsea'); \
          missing <- all_pkgs[!sapply(all_pkgs, requireNamespace, quietly = TRUE)]; \
          if (length(missing) > 0) stop('Failed to install: ', paste(missing, collapse = ', '))"
