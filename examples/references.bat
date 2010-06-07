@echo off

echo Команда sed "" получает данные со входа и выдаёт на выход, т.е.
echo практически ничего не делает, но в этом случае cmd дважды обрабатывает
echo строку
echo.

echo ^> set var=Привет пингвинам
set var=Привет пингвинам

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

echo То же самое, без всяких sed ""
echo ^> setlocal ENABLEDELAYEDEXPANSION
setlocal ENABLEDELAYEDEXPANSION
echo ^> echo %%ref%%=^^^!%%ref%%^^^!
echo %ref%=!%ref%!
