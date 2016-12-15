@echo off &setlocal 

for /f "skip=1 delims== tokens=1,2" %%i in (PromotionPath.ini) do if "%%i"=="CompassSver" set CompassSver=%%j& goto getCompassSverEnd
:getCompassSverEnd

for /f "skip=1 delims== tokens=1,2" %%i in (PromotionPath.ini) do if "%%i"=="CompassUsr" set CompassUsr=%%j& goto getCompassUsrEnd
:getCompassUsrEnd

for /f "skip=1 delims== tokens=1,2" %%i in (PromotionPath.ini) do if "%%i"=="CompassPwd" set CompassPwd=%%j& goto getCompassPwdEnd
:getCompassPwdEnd

for /f "skip=1 delims== tokens=1,2" %%i in (PromotionPath.ini) do if "%%i"=="CompassDB" set CompassDB=%%j& goto getCompassDBEnd
:getCompassDBEnd

for /f "skip=1 delims== tokens=1,2" %%i in (PromotionPath.ini) do if "%%i"=="CompassScriptFolder" set CompassScriptFolder=%%j& goto getCompassScriptFolderEnd
:getCompassScriptFolderEnd

for /f "skip=1 delims== tokens=1,2" %%i in (PromotionPath.ini) do if "%%i"=="CompassSPFolder" set CompassSPFolder=%%j& goto getCompassSPFolderEnd
:getCompassSPFolderEnd

for /f "skip=1 delims== tokens=1,2" %%i in (PromotionPath.ini) do if "%%i"=="CompassViewFolder" set CompassViewFolder=%%j& goto getCompassViewFolderEnd
:getCompassViewFolderEnd

for /f "skip=1 delims== tokens=1,2" %%i in (PromotionPath.ini) do if "%%i"=="NovaSver" set NovaSver=%%j& goto getNovaSverEnd
:getNovaSverEnd

for /f "skip=1 delims== tokens=1,2" %%i in (PromotionPath.ini) do if "%%i"=="NovaUsr" set NovaUsr=%%j& goto getNovaUsrEnd
:getNovaUsrEnd

for /f "skip=1 delims== tokens=1,2" %%i in (PromotionPath.ini) do if "%%i"=="NovaPwd" set NovaPwd=%%j& goto getNovaPwdEnd
:getNovaPwdEnd

for /f "skip=1 delims== tokens=1,2" %%i in (PromotionPath.ini) do if "%%i"=="NovaDB" set NovaDB=%%j& goto getNovaDBEnd
:getNovaDBEnd

for /f "skip=1 delims== tokens=1,2" %%i in (PromotionPath.ini) do if "%%i"=="NovaScriptFolder" set NovaScriptFolder=%%j& goto getNovaScriptFolderEnd
:getNovaScriptFolderEnd

for /f "skip=1 delims== tokens=1,2" %%i in (PromotionPath.ini) do if "%%i"=="NovaSPFolder" set NovaSPFolder=%%j& goto getNovaSPFolderEnd
:getNovaSPFolderEnd

for /f "skip=1 delims== tokens=1,2" %%i in (PromotionPath.ini) do if "%%i"=="NovaViewFolder" set NovaViewFolder=%%j& goto getNovaViewFolderEnd
:getNovaViewFolderEnd

for /f "delims=" %%a in ('dir /B /S /a-d "%CompassScriptFolder%\*.sql"') do ( 
	call osql -U %CompassUsr% -P %CompassPwd% -S %CompassSver% -d %CompassDB% -i "%%a" -o "%%a_out.out"
)

echo Compass Script Complete

for /f "delims=" %%a in ('dir /B /S /a-d "%CompassSPFolder%\*.sql"') do ( 
	call osql -U %CompassUsr% -P %CompassPwd% -S %CompassSver% -d %CompassDB% -i "%%a" -o "%%a_out.out"
)

echo Compass Store Procedure Complete

for /f "delims=" %%a in ('dir /B /S /a-d "%CompassViewFolder%\*.sql"') do ( 
	call osql -U %CompassUsr% -P %CompassPwd% -S %CompassSver% -d %CompassDB% -i "%%a" -o "%%a_out.out"
)

echo Compass View Complete

for /f "delims=" %%a in ('dir /B /S /a-d "%NovaScriptFolder%\*.sql"') do ( 
	call osql -U %NovaUsr% -P %NovaPwd% -S %NovaSver% -d %NovaDB% -i "%%a" -o "%%a_out.out"
)

echo Nova Script Complete

for /f "delims=" %%a in ('dir /B /S /a-d "%NovaSPFolder%\*.sql"') do ( 
	call osql -U %NovaUsr% -P %NovaPwd% -S %NovaSver% -d %NovaDB% -i "%%a" -o "%%a_out.out"
)

echo Nova Store Procedure Complete

for /f "delims=" %%a in ('dir /B /S /a-d "%NovaViewFolder%\*.sql"') do ( 
	call osql -U %NovaUsr% -P %NovaPwd% -S %NovaSver% -d %NovaDB% -i "%%a" -o "%%a_out.out"
)

echo Nova View Complete

pause

endlocal &@echo on