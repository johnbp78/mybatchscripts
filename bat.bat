echo off
if [%1]==[] goto nav
if [%1]==[help] goto useage
pushd c:\bat
dir /b /a-d /o:N
popd
exit /B 0
echo on
:nav
pushd c:\bat
exit /B 0
echo on
:useage
@echo ------------------------------------------------------------------
@echo navigates to batch scripts or lists script files
@echo ------------------------------------------------------------------
@echo Usage: %0 param%%1 
@echo       if param%%1 is any character then list the script files
@echo       if param%%1 help then show this message
@echo ------------------------------------------------------------------


exit /B 1
echo on	