echo off
git fetch
rem validate input
if [%1] == [] goto usage

rem checks for valid branch state and target branch

rem set the variable ResultUncommittedChanges to empty string
set ResultUncommittedChanges=
set i=
for /f %%i in ('git status -s') do set ResultUncommittedChanges=%%i
if NOT [%ResultUncommittedChanges%]==[] goto uncommitted

rem set the variable ResultRemoteBranchExists to empty string
set ResultRemoteBranchExists=
set i=
for /f %%i in ('git branch -r -l *%~1/%2*') do set ResultRemoteBranchExists=%%i
if [%ResultRemoteBranchExists%]==[] goto  notFound

rem - check if the users specified 2 or 3 params
if [%3] == [] goto TwoParam


git checkout %~1/%2
git fetch origin 
git reset --hard origin/%~1/%2
rundll32 user32.dll,MessageBeep


git checkout -b users/%USERNAME%/%1/%2/%3


exit /B 0

echo on


:TwoParam
rem - for when use specifies remote as single parameter
git fetch
git checkout %~1
git fetch origin 
git reset --hard origin/%~1
rundll32 user32.dll,MessageBeep


git checkout -b users/%USERNAME%/%1/%2


exit /B 0

echo on



:usage
rem - help file
@echo -----------------------------------------------------------------------------
@echo %0 creates a new feature branch
@echo     - checks if working tree is clean
@echo 	  - fetches latest code
@echo -----------------------------------------------------------------------------
@echo Usage: %0 param%%1 param%%2 param%%3
@echo       param%%1 the relative path of the branch to operate on. example: release
@echo       param%%2 the branch to operate on. example: 15.0
@echo       param%%3 the name of the feature branch. example defect99999
@echo -----------------------------------------------------------------------------


exit /B 1
echo on


:uncommitted
rem - ERROR - uncommitted changes in current working tree
@echo -------------------------------------------------------------------------
@echo error uncommitted changes!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
@echo *******exiting script before we lose anything important*******
@echo -------------------------------------------------------------------------

exit /b 1
echo on

:notFound
rem - ERROR - remote branch not found
@echo -------------------------------------------------------------------------
@echo remote branch not found  %1/%2
@echo *******exiting script*******
@echo -------------------------------------------------------------------------

exit /b 1
echo on