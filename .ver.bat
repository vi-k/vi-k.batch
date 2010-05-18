@echo off

rem ***************************************************************************
rem * �奬� ���������� ���ᨩ �த�� (�ணࠬ����� ����, ���㬥��, ...)
rem * 
rem * 1.2.3a state [build 4]
rem * 
rem * 1 - major version (�᭮���� ����� ���ᨨ) - �����筮 ����⢥���
rem *     ���������, ��������� �᭮���� �ਭ樯�� �/��� ����⨩.
rem *     ��, �� ������ �� ᮡ�� ������ ��८��祭��/��८��᫥���
rem *     ���짮��⥫ﬨ. � ����設�⢥ �த�⮢ ��� ����� �� �㤥� ��������.
rem *     ���⥬� � ࠧ���묨 major ����ﬨ ����� ���� ���������
rem *     ��ᮢ���⨬묨 ��� � ��㣮�
rem * 2 - minor version (����⥯���� ����� ���ᨨ), ��������� �ଠ⮢
rem *     ������/䠩���, ����⢥��� ��������� ����䥩�, ����������
rem *     �㭪樮������ ���������⥩ (��!)
rem * 3 - release - ����� ���᪠/५��� - ����������/����䨪��� �㭪権,
rem *     ��ࠢ����� �����㦥���� �訡��
rem * a - patch - ��ࠢ����� �訡�� ��᫥ ��室� ५��� (a,b,c,...,z).
rem *     �ᯮ������ � ��砥 ����� �ॡ���� ��ࠢ����� �訡�� � �।��饬
rem *     ५���, � ����� ����� ��� �� �⠡��쭠. ��������� �⤥�쭠� ��⪠
rem *     ��� ��ࠢ������ �訡��, ����� ��⥬ ��७������ � �᭮���� �⢮�.
rem * state - ⥪�饥 ���ﭨ� ���ᨨ: alpha (alpha) - �ᯥਬ��⠫쭠�,
rem *     beta (���-५��) - ��⮢��, stable (᫮�� "stable" �� ������) -
rem *     �����⥫�� ����.
rem * 4 - build - ����� "�����" - �� �����-����� ����⥫쭠� ����䨪���
rem *     �த��, ���� �� ����䨪��� �த�� �᫨ �।���� ����� �뫠
rem *     �뤠�� �� ���짮����� (�� ���஢����, ��ᬮ�� � �.�.).
rem *     ����� ����� �� �������� (����� ���� ����� ������ �� ������
rem *     ����䨪�樨 �஥��. ������� ����७��� ����஬ � ������
rem *     ���짮��⥫� (�஬� ���-���஢) �� �뤠����.
rem * 
rem * �ਬ���:
rem *     1.0.0 alpha - ᠬ�� ��ࢠ� (�ᯥਬ��⠫쭠�) ����� �த��
rem *     1.0.0 beta  - ��ࢠ� �஡��� ����� �뤠���� �� ���஢����
rem *     1.0.0       - ���� ५�� �뤠��� � ॠ�쭮� �ᯮ�짮�����
rem *     1.0.1 aplha - ࠧࠡ�⪠ ����� ���ᨨ �த��
rem *     1.0.0a      - ��ࢮ� ��ࠢ����� �訡�� ५��� 1.0.0 (���� ������
rem *                   ५��� 1.0.1 �� ��������, ⠪ ��� �� �� �⠡����)
rem *     1.0.0b      - ��஥ ��ࠢ����� �訡�� ५��� 1.0.0 (���� ������
rem *                   ५��� 1.0.1 ��� �� �� ��������, ⠪ ��� �� ��
rem *                   �०���� �� �⠡����)
rem *     1.0.1       - ������⥫�� ���������, ���ᥭ�� ��ࠢ����� ��
rem *                   1.0.0a � 1.0.0b
rem *      ...
rem *     1.1.0 alpha - ���������� ����� �㭪樮������ ���������⥩
rem *      ...
rem *     2.0.0 alpha - ���ᬮ�� �᭮���� ���� ॠ����樨/�㭪樮��஢����
rem *                   �த��
rem ***************************************************************************

if not defined unit-with-ver (
  echo �� ������ ��� �����, ᮤ�ঠ饣� ���ଠ�� � ���ᨨ:
  echo set unit-with-ver=���_䠩��
  exit
)
if not exist %unit-with-ver% (
  echo ���� %unit-with-ver% �� ������
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

echo %vermajor%.%verminor%.%verrelease%%verpatch%%space%%verstate% [build %verbranch%%verbuild%] �� %verdate% %vertime%

if "%1"=="" (
  echo �������:
  echo   -       - ��祣� �� �뢮����, ⮫쪮 ������� ��६����;
  echo   ?       - ⥪��� ����� �஥��;
  echo   +       - 㢥����� ����� �����;
  echo   branch  - �������� ���� � ������ �����;
  echo   state   - �������� ���ﭨ� �஥�� ^(� alpha �� beta, � beta �� stable^);
  echo   patch   - �������� patch ^(1.1.1 -^> 1.1.1a -^> 1.1.1b -^> ... 1.1.1z^);
  echo   release - 㢥����� ����� ५��� ^(patch ��⮬���᪨ ���뢠����^);
  echo   minor   - 㢥����� minor ����� ^(release ��⮬���᪨ ���뢠����,
  echo             ���ﭨ� �஥�� �⠭������ alpha^);
  echo   major   - 㢥����� major ����� ^(minor ��⮬���᪨ ���뢠����,
  echo             ���ﭨ� �஥�� �⠭������ alpha^).
  goto end
)
if "%1"=="?" goto end

call :changever %*
if defined error (
  echo ����� ���ᨨ �� �ந�������
  goto end
)
echo %vermajor%.%verminor%.%verrelease%%verpatch%%verstate% [build %verbranch%%verbuild%] �� %verdate% %vertime%

sed -e "s/^#define VERSION \(L\)\?\".*\"/#define VERSION \1\"%vermajor%.%verminor%.%verrelease%%verpatch%%verstate%\"/" -e "s/^#define BUILDNO \(L\)\?\".*\"/#define BUILDNO \1\"[build %verbranch%%verbuild%]\"/" -e "s/^#define BUILDDATE \(L\)\?\".*\"/#define BUILDDATE \1\"%verdate%\"/" -e "s/^#define BUILDTIME \(L\)\?\".*\"/#define BUILDTIME \1\"%vertime%\"/" < %unit-with-ver% > tmp.tmp

if exist %unit-with-ver%.old echo ����� ���ᨨ �� �ந�������. ������ 䠩� %unit-with-ver%.old � ������ & goto end
ren %unit-with-ver% %unit-with-ver%.old
ren tmp.tmp %unit-with-ver%
del %unit-with-ver%.old

:end
del tmp.tmp 2>nul
goto :eof


rem *** getver  ***
:getver
   
   sed -n -e "/^#define VERSION L\?\"\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)\([a-z]\?\) *\(.*\)\"/s//set vermajor=\1\&set verminor=\2\&set verrelease=\3\&set verpatch=\4\&set verstate=\5/p" -e "/^#define BUILDNO L\?\"\[build \([0-9-]\+\-\)\?\([0-9]\+\)\]\"/s//set verbranch=\1\&set verbuild=\2/p" -e "/^#define BUILDDATE L\?\"\(.*\)\"/s//set verdate=\1/p" -e "/^#define BUILDTIME L\?\"\(.*\)\"/s//set vertime=\1/p" >tmp.bat
   rem          ��砫� ��ப�       major       minor       release   patch       state                                                                                                     ��ப� � ������             ����� ��⪨     ����� �����                                                      ��ப� � ��⮩       ���                               ��ப� � �६����   �६�
   call tmp.bat
   del tmp.bat

goto :eof


rem *** changever  ***
:changever
  
  set error=

  rem ���塞 ����
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
      echo ����饥 ���ﭨ� - stable. �������� �����. ������� patch ��� ������� �����.
      exit
    ) else if "%verstate%"=="beta" (
      set verstate=
    ) else (
      echo �������⭮� ⥪�饥 ���ﭨ�.
      echo ������� ������ �� "alpha", "beta" ��� "" [stable].
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
    echo ��������� ��ࠬ���
    set error=1
  )

  rem ���塞 ����
  set /A verbuild=%verbuild%+1

  :end
  if defined verstate (
    set verstate= %verstate%
  )
  
goto :eof

