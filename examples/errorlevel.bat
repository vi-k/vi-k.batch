@echo off

echo ***************************************************************************
echo ��������� if [not] errorlevel number - �뤠�� true �᫨ ��� �訡�� ࠢ��
echo   ��� ������ �᫠ number!!!
echo �뢮�: ���짮������ ⮫쪮 �������樥� if [not] %%errorlevel%%==number
echo ***************************************************************************

echo ������ �訡�� 9009
zzz 2>nul

echo.
echo �訡��� �������樨
echo.

echo �஢�ઠ �� ������⢨� �訡��
if errorlevel 0 echo if errorlevel 0 ... �� �ࠡ�⠫�

echo �஢�ઠ �� �訡�� 9008
if errorlevel 9008 echo if errorlevel 9008 ... �� �ࠡ�⠫�

echo.
echo �������� ��������� (�� �ࠢ��쭮� � �� �� �� ������, �.�. �ࠡ�⠥�
echo � �� �訡��� ��� ������ ����� 9009 (9010, 9011 ...)
echo.

if errorlevel 9009 echo if errorlevel 9009 ...

echo.
echo �ࠢ���� �������樨
echo.

if %errorlevel%==9009 echo if %%errorlevel%%==9009 ... ��
if not %errorlevel%==9008 echo if not %%errorlevel%%==9008 ... OK
if not %errorlevel%==9010 echo if not %%errorlevel%%==9010 ... OK
