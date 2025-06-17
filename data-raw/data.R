tangledDB = make_tangledDB()
usethis::use_data(tangledDB, overwrite = TRUE)

canonical_AAs = c("A", "C", "D", "E", "F", "G", "H", "I", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "Y", "*")
usethis::use_data(canonical_AAs, overwrite = TRUE)
