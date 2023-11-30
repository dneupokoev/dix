#'dix
#'
#' @title dix_log
#'
#' @description text generation function from transmitted parameters
#'
#' @return string
#'
#' @examples dix_log
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

dix_log <- function(print_in01=NA, print_in02=NA, print_in03=NA){
  txt_f_print <- paste0(as.character(Sys.time()), ' | ', as.character(print_in01))
  txt_f_memory <- paste0(' (', round(memory.size(), 0), 'MB)')
  # 
  if (!is.na(print_in02)) {
    if (as.character(print_in02) %in% c('begin', 'end')) {
      txt_f_print <- paste0(txt_f_print, ' | ', as.character(print_in02))
    } else {
      txt_f_print <- paste0(txt_f_print, ' | ', as.character(print_in02), txt_f_memory)
    }
  }
  # 
  if (!is.na(print_in03)) {
    txt_f_print <- paste0(txt_f_print, ' | ', as.character(print_in03))
  }
  # 
  print(txt_f_print, quote = FALSE)
}
