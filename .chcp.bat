@echo off
rem setlocal ENABLEDELAYEDEXPANSION
chcp | sed -n -e "$p" | sed -n -e "s/^[^0-9]*\([0-9]*\).*/set cp=\1/p" >tmp.bat
call tmp.bat
del tmp.bat
echo ���� ������� ��࠭��: %cp%
chcp %1
