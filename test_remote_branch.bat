set ResultRemoteBranchExists=
set i=
for /f %%i in ('git branch -r -l origin/%~1') do set ResultRemoteBranchExists=%%i
if [%ResultRemoteBranchExists%]==[] goto  notFound