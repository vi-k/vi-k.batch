@echo off

REM Для полного понимания чего же тут происходит убери @echo off

set prompt=$G 

@echo НЕБОЛЬШОЙ ФОКУС :-)
@echo 1^%
2^%
3^%
4
@echo.
@echo.

@echo Команда sed "" получает данные со входа и выдаёт на выход, т.е.
@echo практически ничего не делает, но в этом случае cmd дважды обрабатывает
@echo строку
@echo.

@echo ^> echo ^<Hello^> world
echo <Hello> world
@echo.

@echo ^> echo ^^^<Hello^^^> world
echo ^<Hello^> world
@echo.

@echo ^> echo ^^^<Hello^^^> world^| sed ""
echo ^<Hello^> world| sed ""
@echo.

@echo ^> echo ^^^^^^^<Hello^^^^^^^> world^| sed ""
echo ^^^<Hello^^^> world| sed ""
@echo.

@echo ^> echo ^^^^^^^<Hello^^^^^^^> world
echo ^^^<Hello^^^> world
@echo.

