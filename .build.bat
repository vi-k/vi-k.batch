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
echo   ��� compiler - bcc/vc/intel
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
echo compiler: %compiler%

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
set files=%1
set main_file=%~n1
shift /1

:initfiles_next
if not "%1"=="" (
  set files=%files% %1
  shift /1
  goto initfiles_next
)

if not defined files (
  echo �� ����� 䠩� �������樨
  echo.
  goto usage
)

:compile
if defined libs echo %libs%
rem echo _boost=%_boost%
rem echo _wx=%_wx%
echo files: %files%
echo.

del %main_file%.exe 2> nul

if %compiler%==bcc (

  set include=-I"%bcc%\include"
  if defined _boost (
    set include=!include! -I"%_boost%"
  )

  set PATH=!PATH!;%bcc%\bin
  if defined bcc-path set PATH=!PATH!;%bcc-path%

  bcc32.exe !include! -O2 %files%

) else if %compiler%==vc (

  if not defined vc-sdk (
    echo �� ����� ��ࠬ��� vc-sdk
    echo.
    goto usage
  )

  set include=/I "%vc%\include" /I "%vc-sdk%\Include"
  set link=/LIBPATH:"%vc%\lib" /LIBPATH:"%vc-sdk%\Lib"

  if defined _boost (
    set include=!include! /I "%_boost%"
	set link=!link! /LIBPATH:"%_boost%\stage\lib"
  )

  if defined _win32 (
    set link=!link! "%_win32%"
  )

  set PATH=!PATH!;%vc%\bin
  if defined vc-path set PATH=!PATH!;%vc-path%

  REM cl.exe /MT /O2 /EHsc !include! %files% /link !link!
  cl.exe /MTd /Od /EHsc !include! %files% /link !link!

) else if %compiler%==intel (

  if not defined vc-sdk (
    echo �� ����� ��ࠬ��� vc-sdk
    echo.
    goto usage
  )

  set include=/I "%vc%\include" /I "%vc-sdk%\Include"
  set link=/LIBPATH:"%vc%\lib" /LIBPATH:"%vc-sdk%\Lib" /LIBPATH:"%intel%\lib\ia32"
  
  if defined _boost (
    set include=!include! /I "%_boost%"
	set link=!link! /LIBPATH:"%_boost%\stage\lib"
  )

  if defined _win32 (
    set link=!link! "%_win32%"
  )

  set PATH=!PATH!;%intel%\bin\ia32
  if defined vc-path set PATH=!PATH!;%vc-path%

  icl.exe /MT /O2 /EHsc !include! %files% /link !link!

) else (
  echo �� ����� ���������
  echo.
  goto usage
)

if not "%ERRORLEVEL%"=="0" (
  echo.  
  echo �訡�� �������樨
  exit
)

echo.
echo ^>%main_file%.exe
%main_file%.exe
