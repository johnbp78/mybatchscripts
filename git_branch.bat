echo off

rem validate input
if [%1] == [] goto usage


set DirIsRepo=
set i=
for /f %%i in ('git rev-parse --is-inside-work-tree') do set DirIsRepo=%%i
if  not [%DirIsRepo%]==[true] goto dirIsNotRepo

rem checks for valid branch state and target branch

rem set the variable ResultUncommittedChanges to empty string
set ResultUncommittedChanges=
set i=
for /f %%i in ('git status -s') do set ResultUncommittedChanges=%%i
if NOT [%ResultUncommittedChanges%]==[] goto uncommitted

rem - fetch latest
git fetch

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
goto exitSuccess


:TwoParam
rem - for when use specifies remote as single parameter
git fetch
git checkout %~1
git fetch origin 
git reset --hard origin/%~1
rundll32 user32.dll,MessageBeep
git checkout -b users/%USERNAME%/%1/%2
goto exitSuccess



:usage
rem - help file
@echo ---------------------------------------------------------------------------------
@echo 				%0  
@echo - creates a new feature branch
@echo - checks if working tree is clean
@echo - fetches latest code
@echo ---------------------------------------------------------------------------------
@echo Usage: %0 param%%1 param%%2 param%%3		"git_branch release 15.0 70313_08222022"
@echo       param%%1 the relative path of the branch to operate on. example: release
@echo       param%%2 the branch to operate on. example: 15.0
@echo       param%%3 the name of the feature branch. example defect99999
@echo ---------------------------------------------------------------------------------
goto exitSuccess


:uncommitted
rem - ERROR - uncommitted changes in current working tree
@echo -----------------------------------------------------------------------------
@echo error uncommitted changes!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
@echo *******exiting script before we lose anything important*******
@echo -----------------------------------------------------------------------------


goto exitError

:notFound
rem - ERROR - remote branch not found

@echo -----------------------------------------------------------------------------
@echo remote branch not found  %1/%2
@echo *******exiting script*******
@echo -----------------------------------------------------------------------------
goto exitError


:dirIsNotRepo
rem - ERROR - current directory is not a git repository   %CD%
@echo -----------------------------------------------------------------------------
@echo %CD% is not a git repository
@echo *******exiting script*******
@echo -----------------------------------------------------------------------------
goto exitError


:exitError
exit /b 1
echo on

:exitSuccess
exit /B 0
echo on
