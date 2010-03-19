@echo off
if "%2"=="" goto usage
goto start

:err_params

echo Не заданы некоторые параметры для данной системы:
echo.
echo   set bcc=C:\Program Files\Embarcadero\RAD Studio\7.0
echo   set vc=C:\Program Files\Microsoft Visual Studio 9.0\VC
echo   set vcsdk=C:\Program Files\Microsoft SDKs\Windows\v6.0A
echo   set boost=C:\Program Files\boost_1_42_0
echo   set old_boost=C:\Program Files\boost_1_42_0
echo.

:usage

echo Запуск скрипта:
echo   .build.bat compiler file
echo.
echo   где compiler - bcc/bcc_old_boost/vc
echo       file - файл с исходными текстами

exit

:start

if "%1"=="bcc" (

  if not defined bcc goto err_params
  if not defined boost goto err_params

  del %~n2.exe 2> nul
  bcc32 -I"%bcc%\include" -I"%boost%" -O2 %~n2.cpp

) else if "%1"=="bcc_old_boost" (

  if not defined bcc goto err_params
  if not defined old_boost goto err_params

  del %~n2.exe 2> nul
  bcc32 -I"%bcc%\include" -I"%old_boost%" -O2 %~n2.cpp

) else if "%1"=="vc" (

  if not defined vc goto err_params
  if not defined vcsdk goto err_params
  if not defined boost goto err_params

  del %~n2.exe 2> nul
  cl /EHsc /I "%vc%\include" /I "%vcsdk%\Include" /I "%boost%" %~n2.cpp /link /LIBPATH:"%vc%\lib" /LIBPATH:"%vcsdk%\Lib"

) else (
  goto usage
)

if not "%ERRORLEVEL%"=="0" (
  echo.  
  echo Ошибка компиляции
  exit
)

echo.
echo ^>%~n2.exe
%~n2.exe
