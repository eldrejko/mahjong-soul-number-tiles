@echo off
rem Installs the Mahjong Soul number tiles. Close Mahjong Soul first.
setlocal
set "GAME=C:\Program Files (x86)\Steam\steamapps\common\Mahjong Soul\Jantama_MahjongSoul_Data"
if not exist "%GAME%" (
  echo Mahjong Soul not found at "%GAME%".
  set /p "GAME=Paste the path of your Jantama_MahjongSoul_Data folder: "
)
if not exist "%GAME%\StreamingAssets" ( echo That is not the game data folder. & pause & exit /b 1 )
set /a N=0, SKIP=0
for %%D in (StreamingAssets ABM-Fold) do for %%F in ("%~dp0files\%%D\*") do call :put "%%D" "%%~nxF"
echo.
echo Installed %N% file(s), skipped %SKIP%.
if %SKIP% GTR 0 echo Skipped files belong to a different game version - the matching part of the skin won't show.
pause
exit /b

:put
set "T=%GAME%\%~1\StandaloneWindows64\%~2"
if not exist "%T%" ( echo skip %~1\%~2 ^(not in your game^) & set /a SKIP+=1 & exit /b )
if not exist "%~dp0original_backup\%~1" mkdir "%~dp0original_backup\%~1"
if not exist "%~dp0original_backup\%~1\%~2" copy /Y "%T%" "%~dp0original_backup\%~1\%~2" >nul
copy /Y "%~dp0files\%~1\%~2" "%T%" >nul && echo ok   %~1\%~2 && set /a N+=1
exit /b
