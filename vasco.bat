@echo off
setlocal

REM Check if environment is provided
if "%~1"=="" (
    echo Error: No environment specified. Usage: deploy.bat [production|testing]
    exit /b 1
)

set ENV=%~1

REM Switch to the specified environment using alias
echo Switching to %ENV% environment...
firebase use %ENV%

REM Deploy to the specified environment and capture output
echo Deploying to %ENV% environment...
firebase deploy --only hosting > deploy_output.txt

REM Extract URL from the output
for /f "tokens=*" %%i in ('findstr /c:"Hosting URL:" deploy_output.txt') do (
    echo %%i
    set URL=%%i
)

REM Remove the prefix to get just the URL
set URL=%URL:~14%
echo Deployment URL: %URL%

REM Clean up
del deploy_output.txt

echo %ENV% deployment completed!

