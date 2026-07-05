::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFBdBVQGMAE+/Fb4I5/jH6O+GsAAOUfYrdojIl72NL+5e+EDpeoAo1H0XiNkJGhJdaVyibQBU
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSjk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFBdBVQGMAE+/Fb4I5/jHy++Bq0MYcvcxe5vS1brAJfgWig==
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal enabledelayedexpansion
title DefineFunction
chcp 65001 >nul
cd /d C:\Windows\system32
color 7

:: FORCE SHARP CORNERS (Windows 11 DWM API Hack)
set "SHARP_CMD=[DllImport(\"dwmapi.dll\")]public static extern int DwmSetWindowAttribute(IntPtr hwnd, int attr, ref int pv, int cb);"
set "SHARP_CMD=%SHARP_CMD%[DllImport(\"kernel32.dll\")]public static extern IntPtr GetConsoleWindow();"
powershell -NoProfile -Command "Add-Type '%SHARP_CMD%' -Name 'Dwm' -Namespace 'Win'; $h=[Win.Dwm]::GetConsoleWindow(); [int]$v=1; [Win.Dwm]::DwmSetWindowAttribute($h, 33, [ref]$v, 4)" >nul 2>&1

:input
echo.
set "cmd="
set /p cmd="./%username%-%computername%/>"

:: If user pressed enter without typing anything, loop back
if not defined cmd goto input

:: Parse the first word to handle commands or arguments
for /f "tokens=1* delims=, " %%i in ("!cmd!") do (
    set "first_word=%%i"
    set "remaining_words=%%j"
)

:: NATIVE CD FIX: If the user types 'cd', change directory in the main process
if /i "!first_word!"=="cd" (
    if "!remaining_words!"=="" (
        cd
    ) else (
        cd /d "!remaining_words!"
    )
    goto input
)

:: Check for "Define"
if /i "!first_word!"=="Define" (
    set "func_name=!remaining_words!"
    goto prompt_commands
)

:: Check if the user typed a previously saved function name
if defined fn_!cmd! (
    for /f "delims=" %%a in ("!cmd!") do (
        cmd /c "!fn_%%a!"
    )
    goto input
)

:: Check for specific words
if /i "!cmd!"==".computer" (
    echo password = 0302.
    goto input
)

if /i "!cmd!"==".chrome" (
    echo password = Luffy03022612!
    goto input
)

if /i "!cmd!"==".reverse" (
    echo password = 0302Luffy!
    goto input
)

if /i "!cmd!"==".normal" (
    echo password = Luffy0302!
    goto input
)

:: Safely execute general system commands
cmd /c "!cmd!"
goto input


:prompt_commands
if "!func_name!"=="" (
    echo Error: No function name provided!
    goto input
)
set "func_cmd="
set /p func_cmd="Enter commands for !func_name!: "
if not defined func_cmd (
    echo Error: Command cannot be empty.
    goto input
)

:: Dynamic Variable Assignment
set "fn_!func_name!=!func_cmd!"

echo Function [!func_name!] will run: !func_cmd!
goto input
