@ECHO OFF
:Start
title Discord Cache Remover - All Cache
color 5

cd "%APPDATA%/Discord/Cache"
del /S /Q *.*

cd "%APPDATA%/Discord/Code Cache"
del /S /Q *.*

cd "%APPDATA%/Discord/GPUCache"
del /S /Q *.*

:Locales
title Discord Cache Remover - Locales
cd /d "%LOCALAPPDATA%/Discord"
for /f "tokens=*" %%d in ('dir /b /ad-h /o-n "app-*" 2^>nul') do (
    set "latestAppDir=%%d"
    goto :gotLatestAppDir
)

:gotLatestAppDir
if "%latestAppDir%"=="" (
    echo Failed to find the latest app directory.
    PAUSE
    exit /b 1
)
cd "%LOCALAPPDATA%/Discord/%latestAppDir%/locales"
for %%f in (*) do (
    if NOT "%%f"=="en-US.pak" del "%%f"
)

:Modules
title Discord Cache Remover - Modules
cd "%LOCALAPPDATA%/Discord/%latestAppDir%/modules"
for /d %%d in (*) do (
    if NOT "%%d"=="discord_desktop_core-1" (
    if NOT "%%d"=="discord_media-1" (
    if NOT "%%d"=="discord_spellcheck-1" (
    if NOT "%%d"=="discord_utils-1" (
    if NOT "%%d"=="discord_voice-1" (
        rd /s /q "%%d"
    )))))
)

timeout /t 2 /nobreak >nul
cls
echo Cleared all of Discord Cache and removed unnecessary locales and modules!
PAUSE
