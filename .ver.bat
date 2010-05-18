@echo off

rem ***************************************************************************
rem * Схема именования версий продукта (программного кода, документа, ...)
rem * 
rem * 1.2.3a state [build 4]
rem * 
rem * 1 - major version (основной номер версии) - достаточно существенные
rem *     изменения, изменение основных принципов и/или понятий.
rem *     То, что влечёт за собой полное переобучение/переосмысление
rem *     пользователями. В большинстве продуктов этот номер не будет меняться.
rem *     Системы с различными major версиями могут быть полностью
rem *     несовместимыми друг с другом
rem * 2 - minor version (второстепенный номер версии), изменение форматов
rem *     данных/файлов, существенные изменения интерфейса, добавление
rem *     функциональных возможностей (ФВ!)
rem * 3 - release - номер выпуска/релиза - добавление/модификация функций,
rem *     исправление обнаруженных ошибок
rem * a - patch - исправления ошибок после выхода релиза (a,b,c,...,z).
rem *     Используется в случае когда требуется исправление ошибки в предыдущем
rem *     релизе, а новая версия ещё не стабильна. Создаётся отдельная ветка
rem *     где исправляются ошибки, которые затем переносятся в основной ствол.
rem * state - текущее состояние версии: alpha (alpha) - экспериментальная,
rem *     beta (бета-релиз) - тестовая, stable (слово "stable" не пишется) -
rem *     окончательный выпуск.
rem * 4 - build - номер "билда" - любая более-менее значительная модификация
rem *     продукта, либо любая модификация продукта если предыдущая версия была
rem *     выдана на пользование (на тестирование, просмотр и т.д.).
rem *     Номер билда не обнуляется (может быть обнулён вручную при полной
rem *     модификации проекта. Является внутренним номером и конечным
rem *     пользователям (кроме бета-тестеров) не выдаётся.
rem * 
rem * Примеры:
rem *     1.0.0 alpha - самая первая (экспериментальная) версия продукта
rem *     1.0.0 beta  - первая пробная версия выданная на тестирование
rem *     1.0.0       - первый релиз выданный в реальное использование
rem *     1.0.1 aplha - разработка новой версии продукта
rem *     1.0.0a      - первое исправление ошибок релиза 1.0.0 (выпуск нового
rem *                   релиза 1.0.1 не возможен, так как он не стабилен)
rem *     1.0.0b      - второе исправление ошибок релиза 1.0.0 (выпуск нового
rem *                   релиза 1.0.1 всё еще не возможен, так как он по
rem *                   прежнему не стабилен)
rem *     1.0.1       - незначительные изменения, внесение исправлений из
rem *                   1.0.0a и 1.0.0b
rem *      ...
rem *     1.1.0 alpha - добавление новых функциональных возможностей
rem *      ...
rem *     2.0.0 alpha - пересмотр основной идеи реализации/функционирования
rem *                   продукта
rem ***************************************************************************

if not defined unit-with-ver (
  echo Не задано имя модуля, содержащего информацию о версии:
  echo set unit-with-ver=имя_файла
  exit
)
if not exist %unit-with-ver% (
  echo Файл %unit-with-ver% не найден
  exit
)

set vermajor=
set verminor=
set verrelease=
set verpatch=
set verbranch=
set verbuild=
set verstate=
set verdate=
set vertime=

call :getver < %unit-with-ver%
if defined verstate (
  set space= 
)

if "%1"=="-" goto end

echo %vermajor%.%verminor%.%verrelease%%verpatch%%space%%verstate% [build %verbranch%%verbuild%] от %verdate% %vertime%

if "%1"=="" (
  echo Команды:
  echo   -       - ничего не выводить, только рассчитать переменные;
  echo   ?       - текущая версия проекта;
  echo   +       - увеличить номер билда;
  echo   branch  - добавить ветку к номеру билда;
  echo   state   - изменить состояние проекта ^(с alpha на beta, с beta на stable^);
  echo   patch   - добавить patch ^(1.1.1 -^> 1.1.1a -^> 1.1.1b -^> ... 1.1.1z^);
  echo   release - увеличить версию релиза ^(patch автоматически сбрасывается^);
  echo   minor   - увеличить minor версию ^(release автоматически сбрасывается,
  echo             состояние проекта становится alpha^);
  echo   major   - увеличить major версию ^(minor автоматически сбрасывается,
  echo             состояние проекта становится alpha^).
  goto end
)
if "%1"=="?" goto end

call :changever %*
if defined error (
  echo Смена версии не произведена
  goto end
)
echo %vermajor%.%verminor%.%verrelease%%verpatch%%verstate% [build %verbranch%%verbuild%] от %verdate% %vertime%

sed -e "s/^#define VERSION \(L\)\?\".*\"/#define VERSION \1\"%vermajor%.%verminor%.%verrelease%%verpatch%%verstate%\"/" -e "s/^#define BUILDNO \(L\)\?\".*\"/#define BUILDNO \1\"[build %verbranch%%verbuild%]\"/" -e "s/^#define BUILDDATE \(L\)\?\".*\"/#define BUILDDATE \1\"%verdate%\"/" -e "s/^#define BUILDTIME \(L\)\?\".*\"/#define BUILDTIME \1\"%vertime%\"/" < %unit-with-ver% > tmp.tmp

if exist %unit-with-ver%.old echo Смена версии не произведена. Удалите файл %unit-with-ver%.old и повторите & goto end
ren %unit-with-ver% %unit-with-ver%.old
ren tmp.tmp %unit-with-ver%
del %unit-with-ver%.old

:end
del tmp.tmp 2>nul
goto :eof


rem *** getver  ***
:getver
   
   sed -n -e "/^#define VERSION L\?\"\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)\([a-z]\?\) *\(.*\)\"/s//set vermajor=\1\&set verminor=\2\&set verrelease=\3\&set verpatch=\4\&set verstate=\5/p" -e "/^#define BUILDNO L\?\"\[build \([0-9-]\+\-\)\?\([0-9]\+\)\]\"/s//set verbranch=\1\&set verbuild=\2/p" -e "/^#define BUILDDATE L\?\"\(.*\)\"/s//set verdate=\1/p" -e "/^#define BUILDTIME L\?\"\(.*\)\"/s//set vertime=\1/p" >tmp.bat
   rem          Начало строки       major       minor       release   patch       state                                                                                                     Строка с билдом             Номер ветки     Номер билда                                                      Строка с датой       Дата                               Строка со временем   Время
   call tmp.bat
   del tmp.bat

goto :eof


rem *** changever  ***
:changever
  
  set error=

  rem Меняем дату
  udate.exe +"set verdate=%%d.%%m.%%Y&set vertime=%%T" > tmp.bat
  call tmp.bat
  del tmp.bat

  if "%1"=="branch" (
    set verbranch=%verbranch%%verbuild%-
    set verbuild=1
    goto :end
  ) else if "%1"=="state" (
    if "%verstate%"=="alpha" (
      set verstate=beta
    ) else if "%verstate%"=="" (
      echo Текущее состояние - stable. Изменить нельзя. Добавьте patch или измените версию.
      exit
    ) else if "%verstate%"=="beta" (
      set verstate=
    ) else (
      echo Неизвестное текущее состояние.
      echo Измените вручную на "alpha", "beta" или "" [stable].
    )
  ) else if "%1"=="patch" (
    if "%verpatch%"=="" (
      set verpatch=a
    ) else (
      echo abcdefghijklmnopqrstuvwxyz| sed -n "/.*\(%verpatch%\)\(.\).*/s//set verpatch=\2/p" > tmp.bat
      call tmp.bat
      del tmp.bat
   )
  ) else if "%1"=="release" (
    set /A verrelease=%verrelease%+1
    set verpatch=
  ) else if "%1"=="minor" (
    set /A verminor=%verminor%+1
    set verrelease=0
    set verpatch=
    set verstate=alpha
  ) else if "%1"=="major" (
    set /A vermajor=%vermajor%+1
    set verminor=0
    set verrelease=0
    set verpatch=
    set verstate=alpha
  ) else if not "%1"=="+" (
    echo Неизвестный параметр
    set error=1
  )

  rem Меняем билд
  set /A verbuild=%verbuild%+1

  :end
  if defined verstate (
    set verstate= %verstate%
  )
  
goto :eof

