rem test
rem git rev-parse --is-inside-work-tree


set DirIsRepo=
set i=
for /f %%i in ('git rev-parse --is-inside-work-tree') do set DirIsRepo=%%i
if  not [%DirIsRepo%]==[true] goto dirIsNotRepo




:dirIsNotRepo
@echo Directory is not a repository
exit /B 0
echo on

:repoIsValid
@echo Directory is a repository
exit /B 0
echo on