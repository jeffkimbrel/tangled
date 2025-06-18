
<!-- README.md is generated from README.Rmd. Please edit that file -->

``` r
# install.packages("pak")
pak::pak("jeffkimbrel/tangled")
```

Further, `tangled` relies on the `pwalign` package from bioconductor. To
install, run the following.

``` r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("pwalign")
```
