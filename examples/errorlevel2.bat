@echo off

echo ***************************************************************************
echo ������ ᠬ����⥫쭮 ��⠭�������� ��६����� ERRORLEVEL - ��� �������
echo   �ਭ����� ���祭�� ���� ������ �믮��塞�� �ணࠬ�/�������
echo ***************************************************************************

echo.
echo ������ �訡�� 9009
zzz 2>nul
echo ERRORLEVEL=%errorlevel%

echo.
echo ��⠭�������� ERRORLEVEL ������ (set errorlevel=123)
set errorlevel=123
echo ������ �訡�� 9009
zzz 2>nul
echo ERRORLEVEL=%errorlevel%

echo.
echo ����塞 ᮧ������ ���� ��६����� ERRORLEVEL (set errorlevel=)
set errorlevel=
echo ������ �訡�� 9009
zzz 2>nul
echo ERRORLEVEL=%errorlevel%
