@echo off

REM sed -n -e "$p" - �뢥�� ��᫥���� ��ப�
REM sed -n -e "s/^[^0-9]*\([0-9]*\).*/\1/p" - �뤠�� �� ���� �����訥��
REM   ���� (���� �ப�, � ���ன � ᠬ�� ��砫� ���� ��� ᨬ���� �஬�
REM   ���, ���� ��祣� �� �⮨�, ��⥬ ���� ���� � ��⥬ ���, �� 㣮���)

echo ��ਠ�� ��� NT 4.0
echo ��᫥���� ��ப� ����� �ଠ� "xxxxxx ���� ᢮�����"
dir /-C | sed -n -e "$p" | sed -n -e "s/^[^0-9]*\([0-9]*\).*/set size=\1/p" >tmp.bat
call tmp.bat
del tmp.bat

echo ��������� ���� - %size% ����

echo.

set size=

echo ��ਠ�� ��� Win2K
echo ��᫥���� ��ப� ����� �ଠ� "x �����   xxxxxx ���� ᢮�����"
dir /-C | sed -n -e "$p" | sed -n -e "s/^[^0-9]*[0-9]*[^0-9]*\([0-9]*\).*/set size=\1/p" >tmp.bat
call tmp.bat
del tmp.bat

REM dir /-C | sed -n -e "$p" | sed -n -e "s/^[^0-9]*\([0-9]*\).*/\1/p" >tmp.tmp
REM set /P size=<tmp.tmp
REM del tmp.tmp

echo ��������� ���� - %size% ����
