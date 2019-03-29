# dix
универсальные функции для языка R

1. Сначала подключить в скрипте так:

# подключаем пакет с универсальными функциями
if(!"dix" %in% installed.packages()[,1]){devtools::install_github("dneupokoev/dix", upgrade = "never")}
library(dix)
#remove.packages('dix')

Затем вызывать в теле скрипта

dix_print - 
