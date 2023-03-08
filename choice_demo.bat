@ECHO OFF
CLS
ECHO 1.CIMax UI Redux
ECHO 2.CIMax API Redux
ECHO 3.CIMax UI (Cognizant)
ECHO 4.CIMax API (Cognizant)

ECHO.

CHOICE /C 12345 /M "Enter your choice:"

:: Note - list ERRORLEVELS in decreasing order
rem IF ERRORLEVEL 5 GOTO SwitchUser
IF ERRORLEVEL 4 GOTO APICog
IF ERRORLEVEL 3 GOTO UICog
IF ERRORLEVEL 2 GOTO APIRedux
IF ERRORLEVEL 1 GOTO UIRedux 
goto END

:UIRedux
echo ui redux
pushd c:\RCIS_D\CIMaxUIRedux\CIMaxUI
git_branch.bat release/22.10.00 test
popd
GOTO End

:UICog
ECHO UICog
GOTO End

:APIRedux
ECHO APIRedux
GOTO End

:APICog
ECHO APIRedux
GOTO End

REM :SwitchUser
REM ECHO Switch User (put your switch user code here)
REM GOTO End

:End