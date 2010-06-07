@echo off

echo ***************************************************************************
echo НЕЛЬЗЯ самостоятельно устанавливать переменную ERRORLEVEL - она перестаёт
echo   принимать значения кода возврата выполняемых программ/комманд
echo ***************************************************************************

echo.
echo Делаем ошибку 9009
zzz 2>nul
echo ERRORLEVEL=%errorlevel%

echo.
echo Устанавливаем ERRORLEVEL вручную (set errorlevel=123)
set errorlevel=123
echo Делаем ошибку 9009
zzz 2>nul
echo ERRORLEVEL=%errorlevel%

echo.
echo Удаляем созданную нами переменную ERRORLEVEL (set errorlevel=)
set errorlevel=
echo Делаем ошибку 9009
zzz 2>nul
echo ERRORLEVEL=%errorlevel%
