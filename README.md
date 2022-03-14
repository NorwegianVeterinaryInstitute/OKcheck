OKcheck: Tools to facilitate checking of data from National Surveillance Programmes
===================================================================================

<!-- README.md is generated from README.Rmd. Please edit that file -->

-   [Overview](#overview)
-   [Installation](#installation)
-   [Usage](#usage)
-   [Copyright and license](#copyright-and-license)
-   [Contributing](#contributing)

Overview
--------

`OKcheck`provide tools to facilitate checking of data from national
surveillance programmes.

`OKcheck` is part of `NVIverse`, a collection of R-packages with tools
to facilitate data management and data reporting at the Norwegian
Veterinary Institute (NVI). The NVIverse consists of the following
packages: NVIconfig, NVIdb, NVIpretty, NVIbatch, OKplan, OKcheck,
NVIcheckmate, NVIpackager. See the vignette “Contribute to OKcheck” for
more information.

Installation
------------

`OKcheck` is available at
[GitHub](https://github.com/NorwegianVeterinaryInstitute). To install
`OKcheck` you will need:

-   R version &gt; 4.0.0
-   R package `remotes`
-   Rtools 4.0

First install and attach the `remotes` package.

    install.packages("remotes")
    library(remotes)

To install (or update) the `OKcheck` package, run the following code:

    remotes::install_github("NorwegianVeterinaryInstitute/OKcheck")
        upgrade = FALSE,
        build = TRUE,
        build_manual = TRUE)

Usage
-----

The `OKcheck` package needs to be attached.

    library(NVIdb)

`OKcheck`provide tools to facilitate checking of data from national
surveillance programmes.

The full list of all available functions and datasets can be accessed by
typing

    help(package="OKcheck")

Please check the NEWS for information on new features, bug fixes and
other changes.

Copyright and license
---------------------

Copyright (c) 2021 Norwegian Veterinary Institute.  
Licensed under the BSD\_3\_clause License. See
[License](https://github.com/NorwegianVeterinaryInstitute/OKcheck/blob/main/LICENSE)
for details.

Contributing
------------

Contributions to develop `OKcheck` is highly appreciated. There are
several ways you can contribute to this project: ask a question, propose
an idea, report a bug, improve the documentation, or contribute code.
The vignette “Contribute to OKcheck” gives more information.

<!-- Code of conduct -->
------------------------

Please note that the OKcheck project is released with a [Contributor
Code of
Conduct](https://github.com/NorwegianVeterinaryInstitute/OKcheck/blob/main/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.
