@echo off
REM ��� �� ����� ॠ�������� � ������� setlocal

set IFDEBUG=rem
            
rem ��⠥� ��ப� �� 䠩��, ��ࠡ��뢠�� ��, ��࠭塞 ���� ���祭�� � 䠩�,
rem   ��⠭�������� ���� ���祭�� ��६�����, ����⠭�������� ����

echo �� ࠡ�⠥� �� NT 4.0
echo.

rem ��⠥� ��ப�, 㤠�塞 �஡��� �� ���, �࠭��㥬
set strQQ=
sed -n 1p "localvars.ini" | sed -e "s/^[ ]*//" -e "s/[ ]*$//" -e "s/\(.\)/^^^\1/g" >tmp.tmp
set /P strQQ=<tmp.tmp

rem ��⠭�������� ���祭�� �����-����� ��६�����
set a=5
set b=%%5%%
set e=�ਢ�� "���������"

echo ���祭�� �� ᬥ��:
echo a="%a%" b="%b%" c="%c%" d="%d%" e="%e%"
echo.

call :change_var restore_var

echo ���祭�� ��᫥ ᬥ��:
echo a="%a%" b="%b%" c="%c%" d="%d%" e="%e%"
echo.

call restore_var.bat
del restore_var.bat
del tmp.tmp

echo ���祭�� ��᫥ ����⠭�������:
echo a="%a%" b="%b%" c="%c%" d="%d%" e="%e%"
echo.

exit





rem ***************************************************************************
rem * �㭪�� ᬥ�� ���祭�� ��६����� � �����⮢�� ��� ����⠭�������
rem ***************************************************************************

:change_var

   if NOT "%1"=="" echo rem �६���� ������ 䠩� ��� ����⠭������� ���祭�� ��६����� > %1.bat

   :change_var_loop
   if not defined strQQ goto :eof

      rem ���� ��� ��६�����
      set var_name=
      echo %strQQ%| sed -e "/\([^=]*\)\=[^ ]*.*/s//\1/" >tmp.tmp
      set /P var_name=<tmp.tmp

      rem ���� ���祭�� ��६�����
      set var_value=
      echo %strQQ%| sed -e "/[^=]*\=\([^ ]*\).*/s//\1/" -e "s/\(.\)/^\1/g" >tmp.tmp
      set /P var_value=<tmp.tmp

      rem ����稢��� ��ப�
      echo %strQQ%| sed -e "/[^=]*=[^ ]*\(.*\)/s//\1/" -e "s/^[ ]*//" -e "s/\(.\)/^^^\1/g" >tmp.tmp
      set strQQ=
      set /P strQQ=<tmp.tmp

      rem ������塞 ������ 䠩�
      if NOT "%1"=="" echo set %var_name%=%%%var_name%%%| sed -e "s/\(.*\)%%%var_name%%%\(.*\)/\1\2/" -e "s/%%/%%%%/g" >> %1.bat

      rem ��⠭�������� ����� ���祭�� ��६�����
      %IFDEBUG% echo DEBUG - ����� ���祭�� ��६����� (%var_name%=%var_value%)
      set %var_name%=%var_value%

   goto change_var_loop
