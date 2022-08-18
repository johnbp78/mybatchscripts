echo off

rem set the variable RESULT to empty string
set RESULT=
for /f %%i in ('git status -s') do set RESULT=%%i
if NOT [%RESULT%]==[] goto uncommitted


git checkout %~1/%2
git fetch origin 
git reset --hard origin/%~1/%2
rundll32 user32.dll,MessageBeep
@echo Does everything look ok? Press any key to create branch %3 
pause

git checkout -b users/pearj01/%1/%2/%3


exit /B 1

echo on

:usage
@echo ------------------------------------------------------------------
@echo %0 creates a new feature branch after fetching latest code
@echo ------------------------------------------------------------------
@echo Usage: %0 param%%1 param%%2 param%%3
@echo       param%%1 the relative path of the branch to operate on
@echo       param%%2 the branch to operate on
@echo       param%%3 the name of the feature branch ex. defect99999
@echo ------------------------------------------------------------------


exit /B 1
echo on


:uncommitted
@echo --------------------------------------------------------------
@echo error uncommitted changes!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
@echo --------------------------------------------------------------

exit /b 1
echo on