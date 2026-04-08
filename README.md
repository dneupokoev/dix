# dix

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![R-CMD-check](https://github.com/dneupokoev/dix/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dneupokoev/dix/actions)

Универсальные вспомогательные функции для языка R.

## Описание

Пакет **dix** содержит набор универсальных утилит для повседневного программирования на R:

- dix_log.r - **Логирование** — вывод сообщений с меткой времени, уровнем важности и сколько свободно RAM
- dix_write_csv.R - **Запись CSV** — сохранение данных в CSV-файлы с поддержкой кодировки Windows-1251 и сжатия
- dix_eval_timeout.R - **Выполнение с таймаутом** — выполнение R-выражений с ограничением по времени и автоматическими повторными попытками
- dix_send_xmpp_message.R - **XMPP-сообщения** — отправка уведомлений в XMPP-конференции через REST API Prosody

## Установка

```r
# Установка из GitHub
if (!"dix" %in% installed.packages()[, 1]) {
  devtools::install_github("dneupokoev/dix", upgrade = "never")
}
library(dix)
```

## Функции

### dix_print

Форматированный вывод с меткой времени.

```r
dix_print("Сообщение", "Дополнительно", "Ещё")
# 2026-04-08 10:00:00 | Сообщение | Дополнительно | Ещё
```

**Параметры:**
- `print_in01` — основное сообщение (обязательное)
- `print_in02` — дополнительный параметр (необязательный)
- `print_in03` — ещё один дополнительный параметр (необязательный)

### dix_log

Расширенное логирование с отображением размера памяти и уровней важности.

```r
dix_log("Запуск обработки", "begin")
dix_log("Обработка завершена", "end")
dix_log("Произошла ошибка", "ERROR")
dix_log("Информация", "INFO", "детали")
```

**Параметры:**
- `print_in01` — основное сообщение (обязательное)
- `print_in02` — уровень важности или дополнительная информация. Поддерживаемые уровни: `begin`, `end`, `WARNING`, `ERROR`, `INFO`
- `print_in03` — дополнительная информация (необязательный)

### dix_write_csv

Запись data.frame в CSV-файл с автоматическим преобразованием кодировки в Windows-1251.

```r
dix_write_csv(my_dataframe, "output/data.csv")
dix_write_csv(my_dataframe, "output/data.csv.gz", "gz")
```

**Параметры:**
- `param_in01` — data.frame для записи
- `param_in02` — путь к файлу
- `param_in03` — формат сжатия (поддерживается `"gz"`, необязательный)

### dix_eval_timeout

Выполнение R-выражения с ограничением по времени и автоматическими повторными попытками.

```r
result <- dix_eval_timeout(
  time_limit_sec = 30,
  count_attemps = 5,
  eval_exec = "rnorm(100)",
  script_name = "my_script"
)
```

**Параметры:**
- `time_limit_sec` — лимит времени на выполнение в секундах (по умолчанию 60)
- `count_attemps` — количество попыток (по умолчанию 10)
- `eval_exec` — строка с R-выражением для выполнения
- `script_name` — имя скрипта для логирования

**Возвращает:** результат выполнения выражения или строку с описанием ошибки.

### dix_send_xmpp_message

Отправка сообщения в XMPP-конференцию через REST API Prosody.

```r
dix_send_xmpp_message(
  room = "alerts",
  body = "Обработка завершена успешно",
  from = "bot_monitor",
  url = "https://your_domain.example.com:5281/rest-api/send"
)
```

**Параметры:**
- `room` — имя XMPP-комнаты (конференции)
- `body` — текст сообщения
- `from` — имя отправителя (по умолчанию `"bot"`)
- `url` — базовый URL REST API Prosody

## Пример использования

```r
# Подключаем пакет
library(dix)

# Логирование начала работы
dix_log("Начало обработки данных", "begin")

# Печать промежуточного результата
dix_print("Загружено записей: 1500")

# Выполнение кода с таймаутом и повторными попытками
result <- dix_eval_timeout(
  time_limit_sec = 120,
  count_attemps = 3,
  eval_exec = "readRDS('data/large_file.rds')",
  script_name = "data_loader"
)

# Сохранение результата
dix_write_csv(result, "output/result.csv")

# Отправка уведомления
dix_send_xmpp_message(
  room = "reports",
  body = "Отчёт сформирован",
  url = "https://your_domain.example.com:5281/rest-api/send"
)

# Логирование завершения
dix_log("Обработка завершена", "end")
```

## Структура проекта

```
dix/
├── DESCRIPTION          # Метаданные пакета
├── NAMESPACE            # Экспорт функций
├── README.md            # Документация
├── LICENSE              # Лицензия
├── .gitignore           # Игнорируемые файлы
├── dix.Rproj            # Проект RStudio
├── R/                   # Исходный код функций
│   ├── dix_print.R
│   ├── dix_log.r
│   ├── dix_write_csv.R
│   ├── dix_eval_timeout.R
│   └── dix_send_xmpp_message.R
└── man/                 # Документация (roxygen2)
    └── ...
```

## Лицензия

MIT License — см. файл [LICENSE](LICENSE) для подробностей.