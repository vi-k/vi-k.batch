@echo off
if "%2"=="" goto usage
goto start

:usage

echo Запуск скрипта:
echo   .build.bat compiler file
echo.
echo   где compiler - bcc/bcc_old/vc
echo       file - файл с исходными текстами

exit

:start
set bcc=C:\Program Files\Embarcadero\RAD Studio\7.0
set vc=C:\Program Files\Microsoft Visual Studio 9.0\VC
set vcsdk=C:\Program Files\Microsoft SDKs\Windows\v6.0A
set boost=C:\Program Files\boost_1_42_0

del %~n2.exe 2> nul

if "%1"=="bcc" (
  bcc32 -I"%bcc%\include" -I"%boost%" -O2 %~n2.cpp
) else if "%1"=="bcc_old" (
  bcc32 -I"%bcc%\include" -I"C:\Program Files\Embarcadero\RAD Studio\7.0\include\boost_1_39" -O2 %~n2.cpp
) else if "%1"=="vc" (
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
