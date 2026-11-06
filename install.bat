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
for %%F in ("%~dp0files\*") do call :put "%%~nxF"
echo.
echo Installed %N% file(s), skipped %SKIP%.
if %SKIP% GTR 0 echo Skipped files don't match your game version - that part of the skin won't show. Look for a newer release.
pause
exit /b

:put
set "HIT="
for %%D in (StreamingAssets ABM-Fold) do if exist "%GAME%\%%D\StandaloneWindows64\%~1" call :one "%%D" "%~1"
if not defined HIT ( echo skip %~1 ^(not in your game^) & set /a SKIP+=1 )
exit /b

:one
set "HIT=1"
set "T=%GAME%\%~1\StandaloneWindows64\%~2"
call :md5 "%T%"
findstr /x /i /c:"%H%" "%~dp0known.txt" >nul || ( echo skip %~1\%~2 ^(different game version^) & set /a SKIP+=1 & exit /b )
rem save your file only while it is still the untouched original (not another version of this skin)
fc /b "%T%" "%~dp0backup\%~2" >nul 2>&1 && (
  if not exist "%~dp0original_backup\%~1" mkdir "%~dp0original_backup\%~1"
  if not exist "%~dp0original_backup\%~1\%~2" copy /Y "%T%" "%~dp0original_backup\%~1\%~2" >nul
)
copy /Y "%~dp0files\%~2" "%T%" >nul && echo ok   %~1\%~2 && set /a N+=1
exit /b

:md5
set "H=none"
for /f "skip=1 delims=" %%L in ('certutil -hashfile "%~1" MD5') do if "%H%"=="none" set "H=%%L" & goto :md5done
:md5done
set "H=%H: =%"
exit /b
