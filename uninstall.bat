@echo off
rem Puts the original Mahjong Soul files back. Close Mahjong Soul first.
rem Uses the copies install.bat saved (original_backup), or else the untouched originals shipped in backup.
setlocal
set "GAME=C:\Program Files (x86)\Steam\steamapps\common\Mahjong Soul\Jantama_MahjongSoul_Data"
if not exist "%GAME%" set /p "GAME=Paste the path of your Jantama_MahjongSoul_Data folder: "
if not exist "%GAME%\StreamingAssets" ( echo That is not the game data folder. & pause & exit /b 1 )
set "SRC=%~dp0original_backup"
if not exist "%SRC%" set "SRC=%~dp0backup"
for %%D in (StreamingAssets ABM-Fold) do for %%F in ("%SRC%\%%D\*") do (
  if exist "%GAME%\%%D\StandaloneWindows64\%%~nxF" copy /Y "%%F" "%GAME%\%%D\StandaloneWindows64\%%~nxF" >nul && echo restored %%D\%%~nxF
)
echo Done. (Steam "Verify integrity of game files" also restores everything.)
pause
