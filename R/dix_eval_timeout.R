#'dix
#'
#' @title dix_eval_timeout
#'
#' @description Executes the given function, limiting the timeout and the number of attempts
#'
#' @return string/dataframe
#'
#' @examples dix_eval_timeout
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

dix_eval_timeout <- function(time_limit_sec = 60, count_attemps = 10, eval_exec = 'EMPTY', script_name = 'dix_eval_timeout') {
  # time_limit_sec - количество секунд ждать выполнения, после этого отрубать
  # count_attemps - количество попыток
  # eval_exec - конструкция, которую нужно выполнить
  # 
  dv_return <- 'FAIL'
  # count_attemps - Количество попыток, если что-то пошло не так
  dv_stat_count_attemps <- count_attemps
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
        # Делаем небольшую паузу (случайную от 3 до 30 секунд):
        Sys.sleep(sample(3:30, 1))
      }
    )
  }
  # Отображаем количество попыток выполнения eval (если не с первой):
  if (dv_stat_count_attemps > count_attemps) {
    dix_log(paste0(script_name, ' - Количество попыток dix_eval_timeout = ', dv_stat_count_attemps + 1 - count_attemps))
  }
  return(dv_return)
}