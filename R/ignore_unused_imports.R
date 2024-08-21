# Remove NOTE when running CMD check and checking dependencies
# Namespaces in Imports field not imported from:
#   'rlang' 'rmarkdown' 'tidyr'
# All declared Imports should be used.


ignore_unused_imports <- function() {
  # Removes NOTE because of packages needed for Rmd templates used for checking data"
  rmarkdown::html_vignette
  htmltools::knit_print.html
}
