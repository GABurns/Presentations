





VersionFilename <- function(file_path, suffix_type = "integer") {
  # Check if file doesn't already exists
  if (!file.exists(file_path)) {
    # A return will stop the further code running and return the output from
    # within the return (i.e. the file_path)
    return(file_path)
  } else {
    browser()
    basename <-  tools::file_path_sans_ext(basename(file_path))
  }

  # A switch statement is a way to control flow of function
  suffix <- switch(suffix_type,
                   "integer" = {
                     # Check if there is an existing integer suffix
                     if (isTRUE(grepl("_\\d+$", basename))) {
                       version <-
                         as.numeric(stringi::stri_extract_last_regex(basename, "\\d+$")) + 1L
                     } else {
                       version <- 1L
                     }
                   },
                   "datetime" = {
                     version <- format(Sys.Date(), "%d-%m-%y %hm")
                   })

  # Without a return the last thing evaluated will be returned
  # i.e. versionFilePath
  versionedFilePath <-
    file.path(dirname(file_path),
              paste0(basename, "_", suffix, ".", tools::file_ext(file_path)))
}
