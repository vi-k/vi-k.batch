@echo off
goto init

:usage

echo �ਬ��� ��ࠬ��஢ ����᪠�饣� �ਯ�
echo   set bcc=C:\Program Files\Embarcadero\RAD Studio\7.0
echo   set vc=D:\Program Files\Microsoft Visual Studio 9.0\VC
echo   set vc-sdk=C:\Program Files\Microsoft SDKs\Windows\v6.0A
echo   set vc-path=%vc%\Common7\IDE
echo   set lib-boost=@boost-trunk
echo   set lib-boost-1-42=D:\Program Files\boost_1_42_0
echo   set lib-boost-1-42-to=boost
echo   set lib-bcc-boost=%bcc%\include\boost_1_39
echo   set lib-bcc-boost-to=boost
echo   set lib-boost-trunk=D:\Program Files\boost-trunk
echo   set lib-boost-trunk-to=boost
echo.
echo ����� �ਯ�:
echo   .build.bat compiler [+lib]... file
echo.
echo   ��� compiler - bcc/vc
echo       file - 䠩� � ��室�묨 ⥪�⠬�

exit

:init
setlocal ENABLEDELAYEDEXPANSION

set compiler=%1
if not defined compiler (
  echo �� 㪠��� ���������
  echo.
  goto usage
)

:initlibs
shift /1
set lib=%1
if not "%lib:~0,1%"=="+" goto initfiles
set lib=%lib:~1%
:initlibs_link
if not defined %lib% (
  echo �� ��।��� ��ࠬ��� %lib%
  echo.
  goto usage
)

if "!%lib%:~0,1!"=="@" (
  set lib=!%lib%:~1!
  goto initlibs_link
)

if not defined %lib%-to (
  set _%lib%=!%lib%!
) else (
  set _!%lib%-to!=!%lib%!
)

if not defined libs (
  set libs=libs: %lib%
) else (
  set libs=%libs%, %lib%
)

goto initlibs


:initfiles
if "%1"=="" (
  echo �� ����� 䠩� �������樨
  echo.
  goto usage
)


echo compiler: %compiler%
echo %libs%
rem echo _boost=%_boost%
rem echo _wx=%_wx%
echo.

del %~n1.exe 2> nul

if %compiler%==bcc (

  set include=-I"%bcc%\include"
  if defined _boost (
    set include=!include! -I"%_boost%"
  )

  set PATH=!PATH!;%bcc%\bin
  if defined bcc-path set PATH=!PATH!;%bcc-path%

  bcc32.exe !include! -O2 %1

) else if %compiler%==vc (

  if not defined vc-sdk (
    echo �� ����� ��ࠬ��� vc-sdk
    echo.
    goto usage
  )

  set include=/I "%vc%\include" /I "%vc-sdk%\Include"
  if defined _boost (
    set include=!include! /I "%_boost%"
  )

  set PATH=!PATH!;%vc%\bin
  if defined vc-path set PATH=!PATH!;%vc-path%

  cl.exe /EHsc !include! %1 /link /LIBPATH:"%vc%\lib" /LIBPATH:"%vc-sdk%\Lib"

) else (
  rem echo ����୮ ����� ���������
  echo.
  goto usage
)

if not "%ERRORLEVEL%"=="0" (
  echo.  
  echo �訡�� �������樨
  exit
)

echo.
echo ^>%~n1.exe
%~n1.exe
