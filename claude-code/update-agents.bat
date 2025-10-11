@echo off
REM update-agents.bat
REM Pulls latest changes from GitHub and installs/updates agents, commands, and workflows to %USERPROFILE%\.claude\
REM
REM Usage:
REM   update-agents.bat           - Pull and install
REM   update-agents.bat --no-pull - Skip git pull, just install

setlocal enabledelayedexpansion

set SCRIPT_DIR=%~dp0
set NO_PULL=false

if "%1"=="--no-pull" set NO_PULL=true

echo Updating Custom Agents, Commands, Workflows, and Reference Documentation
echo ==========================================================================
echo.

REM Step 1: Pull latest changes from GitHub
if "%NO_PULL%"=="false" (
    echo [INFO] Pulling latest changes from GitHub...
    cd /d "%SCRIPT_DIR%"

    REM Check if git is available
    git --version >nul 2>&1
    if errorlevel 1 (
        echo [ERROR] Git is not installed or not in PATH
        exit /b 1
    )

    REM Get current branch
    for /f "tokens=*" %%i in ('git rev-parse --abbrev-ref HEAD 2^>nul') do set CURRENT_BRANCH=%%i

    if "%CURRENT_BRANCH%"=="" (
        echo [ERROR] Not a git repository
        exit /b 1
    )

    REM Pull latest changes
    git pull origin %CURRENT_BRANCH%
    if errorlevel 1 (
        echo [ERROR] Failed to pull from GitHub
        echo Please resolve any conflicts and try again
        exit /b 1
    )
    echo [OK] Successfully pulled latest changes from %CURRENT_BRANCH%
    echo.
) else (
    echo [INFO] Skipping git pull (--no-pull specified)
    echo.
)

REM Step 2: Run installation script
echo [INFO] Installing agents, commands, workflows, and reference documentation...
call "%SCRIPT_DIR%install-agents.bat"

echo.
echo ==========================================================================
echo [OK] UPDATE COMPLETE
echo.
echo Next steps:
echo   1. Restart Claude Code (if running)
echo   2. Run '/agents' to see available agents
echo   3. Try '/implement-feature' or '/full-review' workflow commands
echo.

endlocal
