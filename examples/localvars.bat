@echo off
REM Всё это можно реализовать с помощью setlocal

set IFDEBUG=rem
            
rem Читаем строку из файла, обрабатываем её, сохраняем старые значения в файл,
rem   устанавливаем новые значения переменных, восстанавливаем старые

echo Не работает на NT 4.0
echo.

rem Читаем строку, удаляем пробелы по краям, экранируем
set strQQ=
sed -n 1p "localvars.ini" | sed -e "s/^[ ]*//" -e "s/[ ]*$//" -e "s/\(.\)/^^^\1/g" >tmp.tmp
set /P strQQ=<tmp.tmp

rem Устанавливаем значения каких-нибудь переменных
set a=5
set b=%%5%%
set e=Привет "пингвинам"

echo Значения до смены:
echo a="%a%" b="%b%" c="%c%" d="%d%" e="%e%"
echo.

call :change_var restore_var

echo Значения после смены:
echo a="%a%" b="%b%" c="%c%" d="%d%" e="%e%"
echo.

call restore_var.bat
del restore_var.bat
del tmp.tmp

echo Значения после восстановления:
echo a="%a%" b="%b%" c="%c%" d="%d%" e="%e%"
echo.

exit





rem ***************************************************************************
rem * Функция смены значений переменных и подготовки для восстановления
rem ***************************************************************************

:change_var

   if NOT "%1"=="" echo rem Временный пакетный файл для восстановления значений переменных > %1.bat

   :change_var_loop
   if not defined strQQ goto :eof

      rem Берём имя переменной
      set var_name=
      echo %strQQ%| sed -e "/\([^=]*\)\=[^ ]*.*/s//\1/" >tmp.tmp
      set /P var_name=<tmp.tmp

      rem Берём значение переменной
      set var_value=
      echo %strQQ%| sed -e "/[^=]*\=\([^ ]*\).*/s//\1/" -e "s/\(.\)/^\1/g" >tmp.tmp
      set /P var_value=<tmp.tmp

      rem Укорачиваем строку
      echo %strQQ%| sed -e "/[^=]*=[^ ]*\(.*\)/s//\1/" -e "s/^[ ]*//" -e "s/\(.\)/^^^\1/g" >tmp.tmp
      set strQQ=
      set /P strQQ=<tmp.tmp

      rem Заполняем пакетный файл
      if NOT "%1"=="" echo set %var_name%=%%%var_name%%%| sed -e "s/\(.*\)%%%var_name%%%\(.*\)/\1\2/" -e "s/%%/%%%%/g" >> %1.bat

      rem Устанавливаем новое значение переменной
      %IFDEBUG% echo DEBUG - Смена значения переменной (%var_name%=%var_value%)
      set %var_name%=%var_value%

   goto change_var_loop
