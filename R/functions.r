#' File extraction 
#' Extracts the TCGA tar.gz to a named output 

#' @param tar.file tar.gz file containing TCGA
#' @param extract.file file which enables the extraction 
#' @param new.file name of desired output file
#' @param resultsdir location of desired output file
#' @return A new extracted file in the specified location 

## function for extracting tcga tar.gz's to named output
extract.file <- function(tar.file, extract.file, new.file, resultsdir) {
  # get file path to extracted file
  x.file <-
    grep(extract.file,
      utils::untar(tar.file, list = T),
      value = T
    )
    
  # extract the tar file
  cat("Extracting", tar.file, "to", new.file, "\n")
  utils::untar(tar.file, exdir=resultsdir, extras="--no-same-owner")
  x.file = file.path(resultsdir,x.file)

  # move the data to named output
  file.copy(x.file, new.file)

  # remove untared directory
  unlink(dirname(x.file), recursive = TRUE)
}


## Extraction of participants
#' Participant extraction 
#' This function will extract participants 
#' @param id TCGA barcode
#' @return participant ID
#' @export

extract.participant <- function(id) {
  sub("TCGA-[^-]+-([^-]+)-.*", "\\1", id)
}