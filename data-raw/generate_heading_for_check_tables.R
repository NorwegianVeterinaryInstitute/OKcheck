## code to prepare `heading_for_check_tables` dataset

heading_for_check_tables <- openxlsx::read.xlsx(paste0(NVIdb::set_dir_NVI("OKprogrammer"), "OKstatistikkApp/StotteData/heading_for_check_tables.xlsx"))

# Save as csv that can be loaded if package is not updated
write.csv2(heading_for_check_tables, 
           file = paste0(NVIdb::set_dir_NVI("OKprogrammer"), "OKstatistikkApp/StotteData/heading_for_check_tables.csv"), 
           row.names = FALSE, 
           fileEncoding = "UTF-8")

rm(heading_for_check_tables)

# Save in package
usethis::use_data(heading_for_check_tables, overwrite = TRUE)
