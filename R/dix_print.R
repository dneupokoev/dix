#'dix
#'
#' @title dix_print
#'
#' @description text generation function from transmitted parameters
#'
#' @return string
#'
#' @examples dix_print
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

dix_print <- function(print_in01=NA, print_in02=NA, print_in03=NA){
  txt_f_print <- paste( as.character(Sys.time()), "|", as.character(print_in01) )

  if (!is.na(print_in02)) {
    txt_f_print <- paste( txt_f_print, "|", as.character(print_in02) )
  }

  if (!is.na(print_in03)) {
    txt_f_print <- paste( txt_f_print, "|", as.character(print_in03) )
  }

  print(txt_f_print, quote=FALSE)
}


