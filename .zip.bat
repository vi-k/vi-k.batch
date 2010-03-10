@echo off
if not defined project-name goto usage
if not defined path-to-archive goto usage
if not defined ver-or-date goto usage
if %ver-or-date%==ver if not defined verunit goto usage
if %ver-or-date%==date if not defined date-format goto usage
goto start

:usage

echo �� ������ ������� ��ࠬ���� ��� ������� �஥��:
echo.
echo   set project-name=��������_�஥��
echo   set path-to-archive=����\�\��娢� - ��� ���⭮�� ��� � ����!
echo   set ver-or-date=ver ��� date - �������� ��娢� - ����� ��� ⥪��� ���
echo   set show-build=1 - �᫨ 1 - �����뢠�� ����� ����� (��� ver-or-date=ver)
echo   set verunit=config.h - 䠩�, ᮤ�ঠ騩 ����� �஥�� (��� ver-or-date=ver)
echo   set date-format=[%%Y-%%m-%%d] - �ଠ� ���� (��� ver-or-date=date)
echo   set default-type=exe - ᯨ᮪ 䠩��� �� 㬮�砭��
echo.
echo ����� �ਯ�:
echo   .zip.bat [type]
echo   ��� type - ᯨ᮪ ����砥��� � ��娢 䠩��� (⨯ ��������)
echo.
echo ���᪨ 䠩��� ��������� ᫥���騬 ��ࠧ��:
echo   .zip-%%type%%.lst - ᯨ᮪ ����砥��� 䠩���
echo   .zip-%%type%%-ignore.lst - ᯨ᮪ �᪫�砥��� 䠩��� (����� �ਮ��� ��।
echo     ᯨ᪮� ����砥��� 䠩���, ����� ������⢮����)
echo   ����
echo   .zip.lst
echo   .zip-ignore.lst

exit

:start

rem ***************************************************************************
rem * ���樠������
rem ***************************************************************************

  set vermajor=
  set verminor=
  set verrelease=
  set verpatch=
  set verbuild=
  set verstate=
  set verdate=
  set zip-name=%project-name%

  set type=%1
  if "%type%"=="" (
    set type=%default-type%
  )
  if "%type%"=="" (
    set lst-file=".zip.lst"
    set ignore-file=".zip-ignore.lst"
  ) else (
    set lst-file=".zip-%type%.lst"
    set ignore-file=".zip-%type%-ignore.lst"
  )
  if exist %ignore-file% set exclude=-exclude=@%ignore-file%

rem ***************************************************************************
rem * ����祭�� ���ᨨ �஥��
rem *  �ਬ��: vidsrv_client-1.0.4[158]-alpha-src.zip
rem ***************************************************************************

if NOT %ver-or-date%==ver goto getdate

  call :getver < %verunit%
  set zip-name=%zip-name%-%vermajor%.%verminor%.%verrelease%%verpatch%
  if "%show-build%"=="1" (
    set zip-name=%zip-name%[%verbuild%]
  )
  if defined verstate (
    set zip-name=%zip-name%-%verstate%
  )
  goto zip

rem ***************************************************************************
rem * ����祭�� ⥪�饩 ����
rem ***************************************************************************

:getdate

  udate.exe +"set verdate=%date-format%" > tmp.bat
  call tmp.bat
  del tmp.bat
  set zip-name=%zip-name%-%verdate%

rem ***************************************************************************
rem * �������� ��娢�
rem ***************************************************************************

:zip

  if NOT "%type%"=="exe" (
    if NOT "%type%"=="" (
      set zip-name=%zip-name%-%type%
    )
  )
  echo ������: %zip-name%

pkzip25 -add -dir=current %exclude% %path-to-archive%\%zip-name% @%lst-file%

exit

rem ***************************************************************************
rem * getver - ����祭�� ���ᨨ �஥��
rem ***************************************************************************

:getver
   
  sed -n -e "/^#define VERSION \"\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)\([a-z]\?\) *\(.*\)\"/s//set vermajor=\1\&set verminor=\2\&set verrelease=\3\&set verpatch=\4\&set verstate=\5/p" -e "/^#define BUILDNO \"\[build \([0-9]*\)\]\"/s//set verbuild=\1/p" -e "/^#define BUILDDATE \"\(.*\)\"/s//set verdate=\1/p" >tmp.bat
  rem          ��砫� ��ப�       major       minor       release   patch       state                                                                                                     ��ப� � ������             ����� �����                              ��ப� � ��⮩       ���
  call tmp.bat
  del tmp.bat

goto :eof
