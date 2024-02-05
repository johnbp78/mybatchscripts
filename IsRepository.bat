
rem checks if the current directory is a git repository
rem parameters:none

set DirIsRepo=
set i=
for /f %%i in ('git rev-parse --is-inside-work-tree') do set DirIsRepo=%%i
if  not [%DirIsRepo%]==[true] goto dirIsNotRepo

echo on
exit /b 0



:dirIsNotRepo
rem - ERROR - current directory is not a git repository   %CD%
@echo -----------------------------------------------------------------------------
@echo %CD% is not a git repository
@echo *******exiting script*******
@echo -----------------------------------------------------------------------------
goto exitError




:exitError
echo on
exit /b 1
echo on