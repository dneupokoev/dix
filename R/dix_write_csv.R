#'dix
#'
#' @title dix_write_csv
#'
#' @description csv-file generation function from parameters
#'
#' @return csv-file
#'
#' @examples dix_write_csv
#'
#' @export
#'
#'
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

dix_write_csv <- function(param_in01=NA, param_in02=NA, param_in03=NA){
  if ( (!is.na(param_in01)) & (!is.na(param_in02)) ) {
    for (i in 1:length(param_in01)) {
      param_in01[[i]] <- iconv(param_in01[[i]], from = "utf-8", to = "windows-1251")
      param_in01[[i]] <- iconv(param_in01[[i]], from = "utf-8", to = "windows-1251")
      }
  
    if (is.na(param_in03)) {
      write.csv(param_in01, file = param_in02, row.names = FALSE, na="")
      } else {
        if (param_in03 == 'gz') {
          write.csv(param_in01, file = gzfile(paste0(param_in02,".",param_in03)), row.names = FALSE, na="")
        }
      }
  }
}
