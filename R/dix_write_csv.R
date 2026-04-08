#' Запись data.frame в CSV-файл с преобразованием кодировки
#'
#' Функция сохраняет data.frame в CSV-файл с автоматическим преобразованием
#' кодировки в Windows-1251. Поддерживает сжатие gzip.
#'
#' @param param_in01 Data.frame для записи. Если не указан, функция ничего не делает.
#' @param param_in02 Путь к выходному файлу (включая имя файла).
#' @param param_in03 Формат сжатия. В настоящее время поддерживается только
#'   \code{"gz"} для gzip-сжатия. Если не указан, файл записывается без сжатия.
#'
#' @return Невидимо возвращает \code{NULL}. Файл записывается на диск.
#'
#' @details
#' Функция автоматически преобразует все строковые столбцы из UTF-8 в
#' Windows-1251 (CP1251) для совместимости с Windows-приложениями (например, Excel).
#'
#' @examples
#' # Запись обычного CSV-файла
#' dix_write_csv(my_data, "output/data.csv")
#'
#' # Запись с gzip-сжатием
#' dix_write_csv(my_data, "output/data.csv.gz", "gz")
#'
#' @export
dix_write_csv <- function(param_in01 = NA, param_in02 = NA, param_in03 = NA) {
  # Проверяем, что указаны данные и путь к файлу
  if ((!is.na(param_in01)) & (!is.na(param_in02))) {
    # Преобразуем кодировку всех строковых элементов в Windows-1251
    # для совместимости с Excel и другими Windows-приложениями
    for (i in 1:length(param_in01)) {
      param_in01[[i]] <- iconv(param_in01[[i]], from = "UTF-8", to = "CP1251")
    }

    # Записываем файл в зависимости от указанного формата
    if (is.na(param_in03)) {
      # Обычная запись без сжатия
      write.csv(param_in01, file = param_in02, row.names = FALSE, na = "")
    } else {
      # Проверка на поддерживаемый формат сжатия
      if (param_in03 == "gz") {
        # Запись с gzip-сжатием
        write.csv(param_in01, file = gzfile(paste0(param_in02, ".", param_in03)), row.names = FALSE, na = "")
      }
    }
  }
}
