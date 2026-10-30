@echo off
rem Puts the original Mahjong Soul files back. Close Mahjong Soul first.
rem Per file: the copy install.bat saved (original_backup), or else the untouched original shipped in backup.
setlocal
set "GAME=C:\Program Files (x86)\Steam\steamapps\common\Mahjong Soul\Jantama_MahjongSoul_Data"
if not exist "%GAME%" set /p "GAME=Paste the path of your Jantama_MahjongSoul_Data folder: "
if not exist "%GAME%\StreamingAssets" ( echo That is not the game data folder. & pause & exit /b 1 )
for %%D in (StreamingAssets ABM-Fold) do for %%F in ("%~dp0backup\%%D\*") do call :get "%%D" "%%~nxF"
echo Done. (Steam "Verify integrity of game files" also restores everything.)
pause
exit /b

:get
set "T=%GAME%\%~1\StandaloneWindows64\%~2"
if not exist "%T%" exit /b
set "S=%~dp0backup\%~1\%~2"
if exist "%~dp0original_backup\%~1\%~2" set "S=%~dp0original_backup\%~1\%~2"
copy /Y "%S%" "%T%" >nul && echo restored %~1\%~2
exit /b
