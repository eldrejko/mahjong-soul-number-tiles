@echo off
rem Puts the original Mahjong Soul files back (the ones install.bat saved). Close Mahjong Soul first.
setlocal
set "GAME=C:\Program Files (x86)\Steam\steamapps\common\Mahjong Soul\Jantama_MahjongSoul_Data"
if not exist "%GAME%" set /p "GAME=Paste the path of your Jantama_MahjongSoul_Data folder: "
if not exist "%~dp0original_backup" ( echo Nothing to restore - install.bat was never run. & pause & exit /b 1 )
for %%D in (StreamingAssets ABM-Fold) do for %%F in ("%~dp0original_backup\%%D\*") do (
  copy /Y "%%F" "%GAME%\%%D\StandaloneWindows64\%%~nxF" >nul && echo restored %%D\%%~nxF
)
echo Done. (Steam "Verify integrity of game files" also restores everything.)
pause
