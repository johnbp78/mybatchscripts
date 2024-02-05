for /l %%i in (1,2,10) do call :process %%i
pause
Exit /b

:process
echo subroutine - %1