@echo off
setlocal enabledelayedexpansion

echo ====================================================================
echo  FluidVoice Parakeet Model & Runtime Installer
echo ====================================================================
echo.

set "SCRIPT_DIR=%~dp0"
set "ROAMING_TARGET=%APPDATA%\com.altic.fluidvoice.windows"
set "LOCAL_TARGET=%LOCALAPPDATA%\FluidVoice"
set "MODEL_TARGET=%ROAMING_TARGET%\models\parakeet-tdt-0.6b-v2"
set "RUNTIME_TARGET=%LOCAL_TARGET%\Runtimes\parakeet-cpp"

echo [*] Checking required files in current folder...
if not exist "%SCRIPT_DIR%tdt-0.6b-v2-q8_0.gguf" (
    echo [ERROR] tdt-0.6b-v2-q8_0.gguf not found! Run "git lfs pull" first.
    pause
    exit /b 1
)

if not exist "%SCRIPT_DIR%.fluidvoice-model.json" (
    echo [ERROR] .fluidvoice-model.json not found!
    pause
    exit /b 1
)

echo.
echo [1/3] Installing Voice Model to:
echo       %MODEL_TARGET%
if not exist "%MODEL_TARGET%" mkdir "%MODEL_TARGET%"
copy /Y "%SCRIPT_DIR%tdt-0.6b-v2-q8_0.gguf" "%MODEL_TARGET%\" >nul
copy /Y "%SCRIPT_DIR%.fluidvoice-model.json" "%MODEL_TARGET%\" >nul
echo       - Model files installed successfully!

echo.
echo [2/3] Installing Parakeet Runtimes to:
echo       %RUNTIME_TARGET%
if exist "%SCRIPT_DIR%Runtimes\parakeet-cpp" (
    if not exist "%RUNTIME_TARGET%" mkdir "%RUNTIME_TARGET%"
    xcopy "%SCRIPT_DIR%Runtimes\parakeet-cpp" "%RUNTIME_TARGET%" /E /I /Y /Q >nul
    echo       - Runtimes installed successfully!
) else (
    echo       - No Runtimes folder found, skipping.
)

echo.
echo [3/3] Checking Settings in:
echo       %ROAMING_TARGET%
if not exist "%ROAMING_TARGET%" mkdir "%ROAMING_TARGET%"
if not exist "%ROAMING_TARGET%\settings.json" (
    if exist "%SCRIPT_DIR%settings.json" (
        copy /Y "%SCRIPT_DIR%settings.json" "%ROAMING_TARGET%\" >nul
        echo       - Default settings.json applied (Parakeet set as active model).
    )
) else (
    echo       - Existing settings.json found, keeping your existing settings.
)

echo.
echo ====================================================================
echo  Installation Complete!
echo  You can now start FluidVoice and Parakeet will be ready to use.
echo ====================================================================
echo.
pause
