@echo off
echo ����⠥� ⮫쪮 �� ����᪥ cmd � ���稪�� /V:ON
echo.

echo set VAR=before
set VAR=before
echo -^> %%VAR%%=%VAR%

(
  echo ^(
  echo   set VAR=after
  set VAR=after
  echo   -^> %%VAR%%=%VAR%
  echo   -^> ^!VAR^!=!VAR!
  echo ^)
)

echo -^> %%VAR%%=%VAR%
echo.

echo setlocal ENABLEDELAYEDEXPANSION
echo.
setlocal ENABLEDELAYEDEXPANSION

echo set VAR=before
set VAR=before
echo -^> %%VAR%%=%VAR%

(
  echo ^(
  echo   set VAR=after
  set VAR=after
  echo   -^> %%VAR%%=%VAR%
  echo   -^> ^^^!VAR^^^!=!VAR!
  echo ^)
)

echo -^> %%VAR%%=%VAR%
echo -^> ^^^!VAR^^^!=!VAR!
