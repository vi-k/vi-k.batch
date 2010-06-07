@echo off

echo ***************************************************************************
echo Конструкция if [not] errorlevel number - выдаёт true если код ошибки равен
echo   ИЛИ БОЛЬШЕ числа number!!!
echo Вывод: пользоваться только конструкцией if [not] %%errorlevel%%==number
echo ***************************************************************************

echo Делаем ошибку 9009
zzz 2>nul

echo.
echo Ошибочные конструкции
echo.

echo Проверка на отсутствие ошибки
if errorlevel 0 echo if errorlevel 0 ... не сработало

echo Проверка на ошибку 9008
if errorlevel 9008 echo if errorlevel 9008 ... не сработало

echo.
echo Работающая конструкция (но правильной я бы её не назвал, т.к. сработает
echo и при ошибках код которых больше 9009 (9010, 9011 ...)
echo.

if errorlevel 9009 echo if errorlevel 9009 ...

echo.
echo Правильные конструкции
echo.

if %errorlevel%==9009 echo if %%errorlevel%%==9009 ... ОК
if not %errorlevel%==9008 echo if not %%errorlevel%%==9008 ... OK
if not %errorlevel%==9010 echo if not %%errorlevel%%==9010 ... OK
