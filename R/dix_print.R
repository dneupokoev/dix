#' @title dix_print
#'
#' @description функция формирования текста из переданных параметров и вывод в консоль для логирования
#'
#' @param параметры (на вход можно подавать фекцию)
#'
#' @return строка: текущая дата и переданные параметры
#'
#' @examples
#'
#' @export
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
