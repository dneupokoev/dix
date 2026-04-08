#' Отправка XMPP сообщения через REST API Prosody (асинхронно)
#'
#' Функция отправляет сообщение в указанную XMPP-комнату (конференцию) через
#' REST API сервера Prosody. Вызов происходит асинхронно через curl в фоновом
#' режиме, функция не дожидается ответа от сервера.
#'
#' @param room Имя комнаты (конференции), например "cmrtlog"
#' @param body Текст отправляемого сообщения
#' @param from Отправитель (по умолчанию "bot")
#' @param url Базовый URL REST API Prosody, например 
#'        "https://your_domain.klml.ru.ru:5281/rest-api/send"
#'
#' @return Возвращает TRUE (невидимо). Результат выполнения curl не отслеживается.
#'
#' @examples
#' \dontrun{
#' dix_send_xmpp_message("cmrtlog", "Тестовое сообщение", 
#'                       url = "https://your_domain.klml.ru.ru:5281/rest-api/send")
#' }
#'
#' @export
#'
dix_send_xmpp_message <- function(room, body, from = "bot", url = "") {
  
  # Проверка обязательных параметров
  if (missing(room) || missing(body)) {
    stop("Параметры 'room' и 'body' обязательны", call. = FALSE)
  }
  
  if (url == "") {
    stop("Параметр 'url' обязателен", call. = FALSE)
  }
  
  # Кодируем body для безопасной передачи в URL
  encoded_body <- URLencode(body, reserved = TRUE)
  
  # Формируем полный URL с параметрами
  url_send <- sprintf("%s?room=%s&from=%s&body=%s", 
                      url, room, from, encoded_body)
  
  # Вызываем curl в фоновом режиме, не дожидаясь ответа
  system2("curl", 
          args = c("-s", shQuote(url_send)),
          stdout = FALSE,
          stderr = FALSE,
          wait = FALSE)
  
  # Возвращаем TRUE невидимо
  invisible(TRUE)
}