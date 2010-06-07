@echo off

rem !!! Переменные являются глобальными !!!

echo.
set /A a=7
call :inc
echo -^> a=%a%

echo.
set /A a=7
call :inc2
echo -^> a=%a%

echo.
set /A a=7
call :inc3
echo -^> a=%a%

exit


:inc
   echo inc(a=%a%)
   echo set /A a=%%a%%+1
   set /A a=%a%+1
   echo a=%a%
goto :eof


rem Функция inc2 (локальные переменные)
:inc2
   echo inc2(a=%a%)
   echo setlocal
   setlocal
   echo set /A a=%%a%%+1
   set /A a=%a%+1
   echo a=%a%
goto :eof

rem Функция inc3 (локальные и глобальные переменные)
:inc3
   echo inc3(a=%a%)
   echo setlocal
   setlocal
   echo set /A a=%%a%%+1
   set /A a=%a%+1
   echo a=%a%
   echo endlocal
   endlocal
   echo a=%a%
   echo set /A a=%%a%%+1
   set /A a=%a%+1
   echo a=%a%
goto :eof
