@echo off

REM sed -n -e "$p" - вывести последнюю строку
REM sed -n -e "s/^[^0-9]*\([0-9]*\).*/\1/p" - выдать все первые попавшиеся
REM   цифры (найти сроку, в которой в самом начале стоят любые символы кроме
REM   цифр, либо ничего не стоит, затем стоят цифры и затем всё, что угодно)

echo Вариант для NT 4.0
echo Последняя строка имеет формат "xxxxxx байт свободно"
dir /-C | sed -n -e "$p" | sed -n -e "s/^[^0-9]*\([0-9]*\).*/set size=\1/p" >tmp.bat
call tmp.bat
del tmp.bat

echo Свободное место - %size% байт

echo.

set size=

echo Вариант для Win2K
echo Последняя строка имеет формат "x папок   xxxxxx байт свободно"
dir /-C | sed -n -e "$p" | sed -n -e "s/^[^0-9]*[0-9]*[^0-9]*\([0-9]*\).*/set size=\1/p" >tmp.bat
call tmp.bat
del tmp.bat

REM dir /-C | sed -n -e "$p" | sed -n -e "s/^[^0-9]*\([0-9]*\).*/\1/p" >tmp.tmp
REM set /P size=<tmp.tmp
REM del tmp.tmp

echo Свободное место - %size% байт
