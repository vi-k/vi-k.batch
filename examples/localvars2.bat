@echo off

rem !!! ��६���� ����� �������묨 !!!

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


rem �㭪�� inc2 (������� ��६����)
:inc2
   echo inc2(a=%a%)
   echo setlocal
   setlocal
   echo set /A a=%%a%%+1
   set /A a=%a%+1
   echo a=%a%
goto :eof

rem �㭪�� inc3 (������� � �������� ��६����)
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
