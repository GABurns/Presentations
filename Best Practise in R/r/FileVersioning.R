#' @title Creates a unique file pathway using simple versioning system
#' @rdname FileVersioning
#' @author Gareth Burns
#' @param filepath either A character string naming a file
#' @param suffix The suffix to append to the basename of file. Can be one of
#' integer, date, datetime or unix timestamp. See Details for more information.
#' @format Date and time format argument passed to \code{\link[base]{format}}
#' @description Wrapper function for file path to check if it already exists and
#' if so appends a suffix to the file name for versioning purposes.
#' @seealso \code{\link[base]{format}}
#' @return The supplied dataframe with standarised terminology
#' @importFrom stringi stri_extract_last_regex
#' @importFrom tools file_path_sans_ext file_ext
#' @export

FileVersioning <-
  function(file_path,
           suffix = "integer",
           format = NULL,
           ...) {
    #Check if directory exists
    if (isFALSE(dir.exists(dirname(file_path)))) {
      stop(
        paste0(
          "The directory ",
          "`",
          dirname(file_path),
          "`",
          " does not exist or does not have appropiate access rights"
        )
      )
    }

    if (file.exists(file_path)) {
      basename <-  tools::file_path_sans_ext(basename(file_path))
      suf <- switch(
        suffix,
        "integer" = {
          # Check if there is an existing integer suffix
          if (isTRUE(grepl("_\\d+$", basename))) {
            version <-
              as.numeric(stringi::stri_extract_last_regex(basename, "\\d+$")) + 1L
            version

          } else {
            version <- 1L
            version
          }
        },
        "date" = {
          # Check for Data at end
          # No functionalality yet but could be used to prevent overwrite on same day
          # grepl("_\\d{2}-\\d{2}-\\d{2}$", basename)
          version <- format(Sys.Date(), "%d-%m-%y")
          version
        },
        "datatime" = {
          # Check for Datatime at end
          # No functionalality yet but could be used to prevent overwrite on same day
          # grepl("_\\d{2}-\\d{2}-\\d{2} \\d{4}$", basename)
          version <- format(Sys.Date(), "%d-%m-%y %hm")
          version
        },
        "unix" = {
          version <- as.numeric(Sys.time())
          version
        }
      )

      versionedFilePath <-
        file.path(dirname(file_path),
                  paste0(basename, "_", suf, ".", tools::file_ext(file_path)))

      return(versionedFilePath)

    } else {
      return(file_path)
    }
  }
