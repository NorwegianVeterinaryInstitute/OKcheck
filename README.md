OKcheck: Tools to facilitate checking of data from national surveillance programmes
================

  - [Overview](#overview)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Copyright and license](#copyright-and-license)
  - [Contributing](#contributing)

# Overview
`OKcheck` comprises tools to facilitate checking of data from national 
surveillance programmes. 

# Installation

`OKcheck` is available at https://github.com/NorwegianVeterinaryInstitute. 
To install `OKcheck` you will need:
  - R version > 4.0.0
  - R package `devtools`
  - Rtools 4.0

First install and attach the `devtools` package.  

``` r
install.packages("devtools")
library(devtools)
```

To install (or update) the `NVIcheckmate` package, run the following code:

``` r
remotes::install_github("NorwegianVeterinaryInstitute/OKcheck", 
	upgrade = FALSE, 
	build = TRUE,
	build_manual = TRUE)
```

# Usage
To come.

# Copyright and license
Copyright 2021 Norwegian Veterinary Institute

Licensed under the BSD 3-Clause License (the "License"); The files in `OKcheck` 
can be used in compliance with the [License](https://opensource.org/licenses/BSD-3-Clause).

# Contributing

Contributions to develop `OKcheck` is highly appreciated. You may, for example, 
contribute by reporting a bug, fixing documentation errors, contributing new code, 
or commenting on issues/pull requests. 

-----

Please note that the OKcheck project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html). By 
contributing to this project, you agree to abide by its terms.
