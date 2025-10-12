@echo off
REM install-agents.bat
REM Installs/updates custom agents, commands, workflows, and reference documentation to %USERPROFILE%\.claude\
REM
REM Usage:
REM   install-agents.bat           - Install/update all agents, commands, and docs
REM   install-agents.bat --dry-run - Show what would be installed without doing it

setlocal enabledelayedexpansion

set SCRIPT_DIR=%~dp0
set CLAUDE_HOME=%USERPROFILE%\.claude
set DRY_RUN=false

if "%1"=="--dry-run" (
    set DRY_RUN=true
    echo DRY RUN MODE - No files will be modified
    echo.
)

echo Installing Custom Agents, Commands, Workflows, and Reference Documentation
echo ==========================================================================
echo.

REM Create directories
echo [INFO] Creating directory structure...
if "%DRY_RUN%"=="true" (
    echo   Would create: %CLAUDE_HOME%\agents
    echo   Would create: %CLAUDE_HOME%\commands
    echo   Would create: %CLAUDE_HOME%\reference-documentation\golang
    echo   Would create: %CLAUDE_HOME%\reference-documentation\python
    echo   Would create: %CLAUDE_HOME%\reference-documentation\typescript
    echo   Would create: %CLAUDE_HOME%\reference-documentation\tailwind
    echo   Would create: %CLAUDE_HOME%\reference-documentation\workflows
    echo   Would create: %CLAUDE_HOME%\reference-documentation\projects
) else (
    if not exist "%CLAUDE_HOME%\agents" mkdir "%CLAUDE_HOME%\agents"
    if not exist "%CLAUDE_HOME%\commands" mkdir "%CLAUDE_HOME%\commands"
    if not exist "%CLAUDE_HOME%\reference-documentation" mkdir "%CLAUDE_HOME%\reference-documentation"
    if not exist "%CLAUDE_HOME%\reference-documentation\golang" mkdir "%CLAUDE_HOME%\reference-documentation\golang"
    if not exist "%CLAUDE_HOME%\reference-documentation\python" mkdir "%CLAUDE_HOME%\reference-documentation\python"
    if not exist "%CLAUDE_HOME%\reference-documentation\typescript" mkdir "%CLAUDE_HOME%\reference-documentation\typescript"
    if not exist "%CLAUDE_HOME%\reference-documentation\tailwind" mkdir "%CLAUDE_HOME%\reference-documentation\tailwind"
    if not exist "%CLAUDE_HOME%\reference-documentation\workflows" mkdir "%CLAUDE_HOME%\reference-documentation\workflows"
    if not exist "%CLAUDE_HOME%\reference-documentation\projects" mkdir "%CLAUDE_HOME%\reference-documentation\projects"
)
echo [OK] Directories created
echo.

REM Copy agents
echo [INFO] Installing agents to %CLAUDE_HOME%\agents\
set AGENT_COUNT=0

for /r "%SCRIPT_DIR%agents" %%f in (*.md) do (
    if "%DRY_RUN%"=="true" (
        echo   Would copy: %%~nxf
    ) else (
        copy /y "%%f" "%CLAUDE_HOME%\agents\" >nul
    )
    set /a AGENT_COUNT+=1
)
echo [OK] Installed %AGENT_COUNT% agent files
echo.

REM Copy commands
echo [INFO] Installing commands to %CLAUDE_HOME%\commands\
set COMMAND_COUNT=0
if exist "%SCRIPT_DIR%commands" (
    for %%f in ("%SCRIPT_DIR%commands\*.md") do (
        if "%DRY_RUN%"=="true" (
            echo   Would copy: %%~nxf
        ) else (
            copy /y "%%f" "%CLAUDE_HOME%\commands\" >nul
        )
        set /a COMMAND_COUNT+=1
    )
    echo [OK] Installed !COMMAND_COUNT! command file(s)
) else (
    echo [WARN] No commands directory found, skipping
)
echo.

REM Copy workflows
echo [INFO] Installing workflow documentation to %CLAUDE_HOME%\reference-documentation\workflows\
set WORKFLOW_COUNT=0
if exist "%SCRIPT_DIR%workflows" (
    for %%f in ("%SCRIPT_DIR%workflows\*.md") do (
        if "%DRY_RUN%"=="true" (
            echo   Would copy: %%~nxf
        ) else (
            copy /y "%%f" "%CLAUDE_HOME%\reference-documentation\workflows\" >nul
        )
        set /a WORKFLOW_COUNT+=1
    )
    echo [OK] Installed !WORKFLOW_COUNT! workflow document(s)
) else (
    echo [WARN] No workflows directory found, skipping
)
echo.

REM Copy reference documentation
echo [INFO] Installing reference documentation to %CLAUDE_HOME%\reference-documentation\

REM Copy root-level reference docs
for %%D in (code-writer.md document-project-layout.md) do (
    if exist "%SCRIPT_DIR%reference-documentation\%%D" (
        if "%DRY_RUN%"=="true" (
            echo   Would copy: %%D
        ) else (
            copy /y "%SCRIPT_DIR%reference-documentation\%%D" "%CLAUDE_HOME%\reference-documentation\" >nul
        )
        echo [OK] Copied %%D
    )
)

REM Copy language-specific docs
for %%L in (golang python typescript tailwind) do (
    if exist "%SCRIPT_DIR%reference-documentation\%%L" (
        set DOC_COUNT=0
        for %%f in ("%SCRIPT_DIR%reference-documentation\%%L\*.md") do (
            if "%DRY_RUN%"=="true" (
                echo   Would copy: %%~nxf to %%L\
            ) else (
                copy /y "%%f" "%CLAUDE_HOME%\reference-documentation\%%L\" >nul
            )
            set /a DOC_COUNT+=1
        )
        if !DOC_COUNT! gtr 0 echo [OK] Copied !DOC_COUNT! file(s) for %%L
    )
)

REM Copy project templates and documentation
if exist "%SCRIPT_DIR%reference-documentation\projects" (
    set PROJECT_DOC_COUNT=0
    for %%f in ("%SCRIPT_DIR%reference-documentation\projects\*.md") do (
        if "%DRY_RUN%"=="true" (
            echo   Would copy: %%~nxf to projects\
        ) else (
            copy /y "%%f" "%CLAUDE_HOME%\reference-documentation\projects\" >nul
        )
        set /a PROJECT_DOC_COUNT+=1
    )
    if !PROJECT_DOC_COUNT! gtr 0 echo [OK] Copied !PROJECT_DOC_COUNT! project template(s)
)
echo.

REM Update reference paths in agent files
if "%DRY_RUN%"=="false" (
    echo [INFO] Updating reference documentation paths in agent files...

    REM PowerShell command to replace paths (more reliable than batch string replacement)
    powershell -Command "$files = Get-ChildItem '%CLAUDE_HOME%\agents\*.md'; foreach ($file in $files) { (Get-Content $file.FullName) -replace '\]\(\.\./reference-documentation/', '](~/.claude/reference-documentation/' | Set-Content $file.FullName }"

    echo [OK] Updated reference paths
) else (
    echo   Would update reference paths in all agent files
)
echo.

REM Summary
echo ==========================================================================
if "%DRY_RUN%"=="true" (
    echo DRY RUN COMPLETE
    echo No files were modified. Run without --dry-run to install.
) else (
    echo INSTALLATION COMPLETE
    echo.
    echo Installed to:
    echo   * Agents: %CLAUDE_HOME%\agents\ (!AGENT_COUNT! files)
    echo   * Commands: %CLAUDE_HOME%\commands\ (!COMMAND_COUNT! files)
    echo   * Workflows: %CLAUDE_HOME%\reference-documentation\workflows\ (!WORKFLOW_COUNT! files)
    echo   * Reference Docs: %CLAUDE_HOME%\reference-documentation\
    echo.
    echo Next steps:
    echo   1. Restart Claude Code (if running)
    echo   2. Run '/agents' to see available agents
    echo   3. Try '/implement-feature' or '/full-review' commands
    echo   4. Read workflow guides in %USERPROFILE%\.claude\reference-documentation\workflows\
)
echo.

endlocal
