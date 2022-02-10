## code to prepare `heading_for_check_tables` dataset

heading_for_check_tables <- openxlsx::read.xlsx("./data-raw/heading_for_check_tables.xlsx")

write.csv2(heading_for_check_tables, file = "./data-raw/heading_for_check_tables.csv", row.names = FALSE, fileEncoding = "UTF-8")

heading_for_check_tables <- read.csv2(file = "./data-raw/heading_for_check_tables.csv", fileEncoding = "UTF-8")

usethis::use_data(heading_for_check_tables, overwrite = TRUE)
