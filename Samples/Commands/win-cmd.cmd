@echo off
setlocal ENABLEEXTENSIONS

:: ----------- Configurable Paths -----------

set "TARGET_VERSION=8"
set "TOOL=..\..\..\..\FlatTablesTool\FlatTablesTool.dll"
set "INPUT_DATA_SOURCE=..\DataSource"
set "OUTPUT_CODE_DIR=..\Client\Generated\Code"
set "OUTPUT_BIN_DIR=..\Client\Generated\Bin\Resources"
set "TARGET_CODE_LANGUAGE=csharp"

:: ----------- Function: Check if dotnet installed and version -----------

set "DOTNET_OK=0"
for /f "tokens=1 delims=." %%v in ('dotnet --version 2^>nul') do (
    if %%v GEQ %TARGET_VERSION% (
        set "DOTNET_OK=1"
    )
)

if %DOTNET_OK%==1 (
    echo [OK] .NET SDK version %TARGET_VERSION% or higher is installed.
    goto run
)

echo [WARN] .NET SDK %TARGET_VERSION%+ not detected.

:: ----------- Try auto install using winget or choco -----------

where winget >nul 2>&1
if %ERRORLEVEL%==0 (
    echo Attempting to install .NET SDK using winget...
    winget install --id Microsoft.DotNet.SDK.8 --accept-package-agreements --accept-source-agreements
    goto check_again
)

where choco >nul 2>&1
if %ERRORLEVEL%==0 (
    echo Attempting to install .NET SDK using Chocolatey...
    choco install dotnet-8.0-sdk -y
    goto check_again
)

:: ----------- Manual fallback -----------

echo [ERROR] No supported package manager found for automatic installation.
echo Opening the official .NET SDK download page...
start https://dotnet.microsoft.com/en-us/download/dotnet/8.0
echo Please install manually, then press any key to continue...
pause >nul

:check_again
set "DOTNET_OK=0"
for /f "tokens=1 delims=." %%v in ('dotnet --version 2^>nul') do (
    if %%v GEQ %TARGET_VERSION% (
        set "DOTNET_OK=1"
    )
)

if %DOTNET_OK%==0 (
    echo [FATAL] .NET SDK is still not installed. Exiting.
    pause
    exit /b
)

:: ----------- Execute Tool -----------

:run
if not exist "%TOOL%" (
    echo [ERROR] Tool not found at path: %TOOL%
    pause
    exit /b
)

echo Running FlatTablesTool...
dotnet "%TOOL%" "%INPUT_DATA_SOURCE%" "%OUTPUT_CODE_DIR%" "%OUTPUT_BIN_DIR%" "%TARGET_CODE_LANGUAGE%"

pause
