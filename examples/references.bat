@echo off

echo ������� sed "" ����砥� ����� � �室� � �뤠�� �� ��室, �.�.
echo �ࠪ��᪨ ��祣� �� ������, �� � �⮬ ��砥 cmd ������ ��ࠡ��뢠��
echo ��ப�
echo.

echo ^> set var=�ਢ�� ���������
set var=�ਢ�� ���������

echo ^> set ref=var
set ref=var
echo.

echo ^> echo var=%%var%%
echo var=%var%
echo.

echo ^> echo ref=%%ref%%
echo ref=%ref%
echo.

echo ^> echo %%ref%%=%%%%%%ref%%%%%%
echo %ref%=%%%ref%%%
echo.

echo ^> echo %%ref%%=%%%%%%ref%%%%%%^| sed ""
echo %ref%=%%%ref%%%| sed ""
echo.

echo �� �� ᠬ��, ��� ��直� sed ""
echo ^> setlocal ENABLEDELAYEDEXPANSION
setlocal ENABLEDELAYEDEXPANSION
echo ^> echo %%ref%%=^^^!%%ref%%^^^!
echo %ref%=!%ref%!
