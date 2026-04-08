#' Выполнение R-выражения с таймаутом и повторными попытками
#'
#' Функция выполняет произвольное R-выражение, ограничивая время выполнения
#' и количество попыток. При ошибке или превышении времени делается случайная
#' пауза перед следующей попыткой.
#'
#' @param time_limit_sec Лимит времени на выполнение в секундах (по умолчанию 60).
#'   По истечении этого времени выполнение будет прервано.
#' @param count_attemps Количество попыток выполнения (по умолчанию 10).
#' @param eval_exec Строка с R-выражением для выполнения.
#' @param script_name Имя скрипта для логирования (по умолчанию 'dix_eval_timeout').
#'
#' @return Результат выполнения выражения или строку с описанием ошибки,
#'   если все попытки исчерпаны.
#'
#' @details
#' Функция использует \code{setTimeLimit} для ограничения времени выполнения
#' и \code{tryCatch} для перехвата ошибок. При возникновении ошибки делается
#' случайная пауза от 3 до 120 секунд перед следующей попыткой.
#'
#' Если выполнение потребовало более одной попытки, в лог выводится
#' информация о количестве попыток.
#'
#' @examples
#' \dontrun{
#' # Простое выполнение
#' result <- dix_eval_timeout(
#'   time_limit_sec = 30,
#'   count_attemps = 3,
#'   eval_exec = "rnorm(100)"
#' )
#'
#' # Загрузка большого файла с повторными попытками
#' data <- dix_eval_timeout(
#'   time_limit_sec = 120,
#'   count_attemps = 5,
#'   eval_exec = "readRDS('data/large_file.rds')",
#'   script_name = "data_loader"
#' )
#' }
#'
#' @export
dix_eval_timeout <- function(time_limit_sec = 60, count_attemps = 10, eval_exec = "EMPTY", script_name = "dix_eval_timeout") {
  # time_limit_sec  - лимит времени выполнения в секундах
  # count_attemps   - количество попыток выполнения
  # eval_exec       - R-выражение для выполнения (строка)
  # script_name     - имя скрипта для логирования

  dv_return <- "FAIL"
  # Максимальное время для паузы в случае ошибки (секунды):
  dv_pause_sec_max <- 120
  # Счётчик выполненных попыток для статистики:
  dv_stat_count_attemps <- 0

  # Цикл повторных попыток
  while (count_attemps > 0) {
    tryCatch(
      expr = {
        dv_stat_count_attemps <- dv_stat_count_attemps + 1

        # Устанавливаем лимиты времени для текущего выполнения
        setTimeLimit(cpu = time_limit_sec, elapsed = time_limit_sec, transient = TRUE)
        # После выхода сбрасываем лимиты
        on.exit({
          setTimeLimit(cpu = Inf, elapsed = Inf, transient = FALSE)
        })

        # Выполняем переданное выражение
        dv_return <- eval(parse(text = eval_exec))

        # Если выполнение прошло успешно — выходим из цикла
        break
      },
      error = function(e) {
        # Сохраняем информацию об ошибке
        dv_return <<- paste0("ERROR *** ", e)

        # Временно увеличиваем лимит для паузы
        setTimeLimit(cpu = dv_pause_sec_max + 10, elapsed = dv_pause_sec_max + 10, transient = TRUE)
        on.exit({
          setTimeLimit(cpu = Inf, elapsed = Inf, transient = FALSE)
        })

        # Логгируем ошибку и делаем случайную паузу
        dix_log(paste0(script_name, " - dix_eval_timeout PAUSE: ", e))
        Sys.sleep(sample(3:dv_pause_sec_max, 1))
      },
      finally = {
        # Уменьшаем счётчик оставшихся попыток
        count_attemps <- count_attemps - 1
      }
    )
  }

  # Выводим статистику, если потребовалось более одной попытки
  if (dv_stat_count_attemps > 1) {
    dix_log(paste0(script_name, " - Number of attempts dix_eval_timeout = ", dv_stat_count_attemps, " *** ", eval_exec))
  }

  return(dv_return)
}
