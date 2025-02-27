# OKcheck 0.3.5 - (2025-02-14)

## Bug fixes:

- `count_PJScodes` now accepts an empty `data.frame` as input to PJSdata.


## Other changes:

- Attached NVIpjsr in all Rmd-templates used in check-routines. 

- Uses internal pipe |> and updated dependencies to R 4.1.0.


# OKcheck 0.3.4 - (2024-08-21)

## Other changes:

- Updated help in README.

- Updated dependencies to `NVIpjsr::choose_PJS_levels`  and `NVIpjsr::add_PJS_code_description` for `count_PJScodes`. 


# OKcheck 0.3.3 - (2023-06-22)

## Bug fixes:

- Corrected heading in "check_ok_selection_parameters.Rmd" when year is more than one year.


# OKcheck 0.3.2 - (2023-06-01)

## New features:

- Improved `count_PJScodes` so that the argument `accepted` handles codes with ending "%" to include sub-levels of the code.


## Other changes:

- Standardised help and included links. 

- Improved argument checking for `find_accepted_code`.

- Include rmarkdown template "check_ok_selection_parameters" for better reporting from `count_PJScodes` for hensiktkoder, metodekoder and konklusjonsanalyttkoder when checking the selection parameters for selecting data for diseases from PJS.


# OKcheck 0.3.0 - (2023-02-20)


## New features:

- Created `check_ok_PJSdata` to facilitate output of check result in a browser or send the output file by email. `check_ok_data` is a wrapper for `NVIbatch::output_rendered`.


## Bug fixes:

- Fixed difficulties in installing due to dependencies when building the vignettes: Contribute_to_OKcheck.


## Other changes:

- Updated README and corrected installation guidelines.

- Updated CONTRIBUTING and the vignette: Contribute_to_OKcheck.


# OKcheck 0.2.1 - (2022-03-14)

## Bug fixes:

- The setting of the variable accept was taken out of the package and must be set in the script using the the Rmd-files.


# OKcheck 0.2.0 - (2022-03-14)

## New features:

- 'find_accepted_code' supports combinations of variables.

- 'ok_check_data.Rmd' selects accepted_codes based on 'accept_always' or 'accept_in_auto_check' 

- the child document 'ok_check_combinations.Rmd' checks PJSdata for accepted combinations.


Other features:

- OKcheck is dependent on NVIdb >= v0.7.0 due to the dependency of 'NVIdb::add_PJS_code_description' in this version..

  
# OKcheck 0.1.0 - (2022-01-07)

## First release: Tools to facilitate checking of data from National Surveillance Programmes.

- 'count_PJScodes' gives an overview of codes used for a variable.

- 'find_accepted_codes' look up in a table with accepted codes and returns the accepted codes. Combinations of variables are not supported yet.

- 'knit_table_if_data' Knits a table with heading if there are data. Used in the Rmarkdown-documents to ensure that a report is only generated when there are something to report. 

- 'OK_check_data.Rmd' and child Rmd-files checks PJS-data to identify registrations that are wrong. 
