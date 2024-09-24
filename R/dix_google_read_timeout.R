#'dix
#'
#' @title dix_google_read_timeout
#'
#' @description Reading a Google Sheet Taking into Account Timeout and Number of Attempts
#'
#' @return string/dataframe
#'
#' @examples dix_google_read_timeout
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

dix_google_read_timeout <- function(time_limit_sec = 10, count_attemps = 5, eval_exec = 'EMPTY') {
  dv_return <- 'FAIL'
  # count_attemps - Количество попыток, если что-то пошло не так
  # Задаем параметры с указанием лимитов:
  setTimeLimit(cpu = time_limit_sec, elapsed = time_limit_sec, transient = TRUE)
  on.exit({
    setTimeLimit(cpu = Inf, elapsed = Inf, transient = FALSE)
  })
  while (count_attemps >= 0) {
    # Тело скрипта:
    tryCatch(
      expr = {
        # Здесь выполняем нужное:
        dv_return <- eval(parse(text=eval_exec))
        # Если дошли до этого места, то всё норм и прерываем цикл:
        break
      },
      error = function(e) {
        dv_return <<- paste0('ERROR *** ', e)
      },
      finally = {
        count_attemps = count_attemps - 1
        # Делаем небольшую паузу:
        Sys.sleep(1)
      }
    )
  }
  return(dv_return)
}