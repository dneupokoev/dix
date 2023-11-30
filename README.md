# dix
<p>
<br>универсальные функции для языка R
<br>
<br><b>Сначала подключить пакет в скрипте так:</b>
<br>
<br># подключаем пакет с универсальными функциями
<br>if(!"dix" %in% installed.packages()[,1]){devtools::install_github("dneupokoev/dix", upgrade = "never")}
<br>library(dix)
<br>#remove.packages('dix')
<br>
<br><b>Затем вызывать в теле скрипта</b>
<br>
<br>dix_print - 
<br>dix_log - 
<br>dix_write_csv - 
<br>
</p>
