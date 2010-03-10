@echo off
if not defined project-name goto usage
if not defined path-to-archive goto usage
if not defined ver-or-date goto usage
if %ver-or-date%==ver if not defined verunit goto usage
if %ver-or-date%==date if not defined date-format goto usage
goto start

:usage

echo Не заданы некоторые параметры для данного проекта:
echo.
echo   set project-name=Название_проекта
echo   set path-to-archive=Путь\к\архиву - без обратного слэша в конце!
echo   set ver-or-date=ver или date - название архива - версия или текущая дата
echo   set show-build=1 - если 1 - показывать версию билда (для ver-or-date=ver)
echo   set verunit=config.h - файл, содержащий версию проекта (для ver-or-date=ver)
echo   set date-format=[%%Y-%%m-%%d] - формат даты (для ver-or-date=date)
echo   set default-type=exe - список файлов по умолчанию
echo.
echo Запуск скрипта:
echo   .zip.bat [type]
echo   где type - список включаемых в архив файлов (тип комплекта)
echo.
echo Списки файлов именуются следующим образом:
echo   .zip-%%type%%.lst - список включаемых файлов
echo   .zip-%%type%%-ignore.lst - список исключаемых файлов (имеет приоритет перед
echo     списком включаемых файлов, может отсутствовать)
echo   либо
echo   .zip.lst
echo   .zip-ignore.lst

exit

:start

rem ***************************************************************************
rem * Инициализация
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
rem * Получение версии проекта
rem *  Пример: vidsrv_client-1.0.4[158]-alpha-src.zip
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
rem * Получение текущей даты
rem ***************************************************************************

:getdate

  udate.exe +"set verdate=%date-format%" > tmp.bat
  call tmp.bat
  del tmp.bat
  set zip-name=%zip-name%-%verdate%

rem ***************************************************************************
rem * Создание архива
rem ***************************************************************************

:zip

  if NOT "%type%"=="exe" (
    if NOT "%type%"=="" (
      set zip-name=%zip-name%-%type%
    )
  )
  echo Создаём: %zip-name%

pkzip25 -add -dir=current %exclude% %path-to-archive%\%zip-name% @%lst-file%

exit

rem ***************************************************************************
rem * getver - получение версии проекта
rem ***************************************************************************

:getver
   
  sed -n -e "/^#define VERSION \"\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)\([a-z]\?\) *\(.*\)\"/s//set vermajor=\1\&set verminor=\2\&set verrelease=\3\&set verpatch=\4\&set verstate=\5/p" -e "/^#define BUILDNO \"\[build \([0-9]*\)\]\"/s//set verbuild=\1/p" -e "/^#define BUILDDATE \"\(.*\)\"/s//set verdate=\1/p" >tmp.bat
  rem          Начало строки       major       minor       release   patch       state                                                                                                     Строка с билдом             Номер билда                              Строка с датой       Дата
  call tmp.bat
  del tmp.bat

goto :eof
