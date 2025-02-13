@echo off
:menu
cls
:: Cleaner UI for the title
echo.
echo.  ==========================================
echo.      Discord Webhook Message Sender
echo.  ==========================================
echo.
echo.  1. Send a Message
echo.  2. Delete a Webhook
echo.  3. Spam a Message (1 Second Loop)
echo.  4. Exit
echo.
set /p choice=Choose an option (1-4): 

if "%choice%"=="1" goto sendmessage
if "%choice%"=="2" goto deletewebhook
if "%choice%"=="3" goto spammessage
if "%choice%"=="4" exit

echo Invalid choice. Please try again.
pause
goto menu

:sendmessage
cls
:: Cleaner UI for the message sender
echo.
echo.  ==========================================
echo.      Send a Message to Discord
echo.  ==========================================
echo.
set /p webhook_url=Enter your Discord webhook URL: 
if "%webhook_url%"=="" (
    echo Webhook URL cannot be empty!
    pause
    goto sendmessage
)

set /p message=Enter your message: 
if "%message%"=="" (
    echo Message cannot be empty!
    pause
    goto sendmessage
)

:: Use PowerShell to send the message and display the time
powershell -Command "$webhookUrl = '%webhook_url%'; $message = '%message%'; Write-Host '[*] Sending message...' -ForegroundColor Blue; $response = Invoke-RestMethod -Uri $webhookUrl -Method Post -Body (@{content=$message} | ConvertTo-Json) -ContentType 'application/json'; if ($?) { $time = Get-Date -Format 'HH:mm:ss'; Write-Host ('[+] Message Sent! (' + $time + ')') -ForegroundColor Green } else { Write-Host '[-] Failed to send the message.' -ForegroundColor Red }"

pause
goto menu

:deletewebhook
cls
:: Cleaner UI for the webhook deletion
echo.
echo.  ==========================================
echo.      Delete a Discord Webhook
echo.  ==========================================
echo.
set /p webhook_url=Enter the Discord webhook URL to delete: 
if "%webhook_url%"=="" (
    echo Webhook URL cannot be empty!
    pause
    goto deletewebhook
)

:: Use PowerShell to delete the webhook
powershell -Command "$webhookUrl = '%webhook_url%'; Write-Host '[*] Deleting webhook...' -ForegroundColor Blue; $response = Invoke-RestMethod -Uri $webhookUrl -Method Delete; if ($?) { Write-Host '[+] Webhook deleted successfully!' -ForegroundColor Green } else { Write-Host '[-] Failed to delete the webhook.' -ForegroundColor Red }"

pause
goto menu

:spammessage
cls
:: Cleaner UI for the spam message feature
echo.
echo.  ==========================================
echo.      Spam a Message to Discord (1 Second Loop)
echo.  ==========================================
echo.
set /p webhook_url=Enter your Discord webhook URL: 
if "%webhook_url%"=="" (
    echo Webhook URL cannot be empty!
    pause
    goto spammessage
)

set /p message=Enter your message: 
if "%message%"=="" (
    echo Message cannot be empty!
    pause
    goto spammessage
)

:: Start spamming the message in a loop (1 second delay)
echo.
echo [*] Spamming message every 1 second. Press Ctrl + C to stop.
:spamloop
powershell -Command "$webhookUrl = '%webhook_url%'; $message = '%message%'; $response = Invoke-RestMethod -Uri $webhookUrl -Method Post -Body (@{content=$message} | ConvertTo-Json) -ContentType 'application/json'; if ($?) { $time = Get-Date -Format 'HH:mm:ss'; Write-Host ('[+] Message Sent! (' + $time + ')') -ForegroundColor Green } else { Write-Host '[-] Failed to send the message.' -ForegroundColor Red }"
timeout /t 1 /nobreak >nul
goto spamloop