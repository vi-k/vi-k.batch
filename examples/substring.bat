@echo off

echo Взятие подстроки
echo.

set var=Hello, World
echo ^> set var=Hello, World
echo ^> echo %%var:~7,5%%, %%var:~0,5%%!
echo %var:~7,5%, %var:~0,5%!
