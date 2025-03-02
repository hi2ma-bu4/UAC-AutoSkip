@echo off
setlocal enabledelayedexpansion
Set nowPath=%~dp0
Set doTask=doTask.vbs
Set doApp=doApp.bat
Set userTxt=current_user.txt
Set folderName=�V���[�g�J�b�g�Q

cd "%nowPath%"

If not exist %folderName% mkdir %folderName%

if not "%~1"=="" (
	if "%~2"=="1" (
		start "" /d "%nowPath%" "%folderName%\%~1.lnk"
	) else if "%~2"=="" (
		start "" /d "%nowPath%" "%doTask%" "%~1" 1
	) else (
		echo. ����2��1�ł͂���܂���I
	)
) else (
	whoami /priv | find "SeDebugPrivilege" > nul
	if !errorlevel! neq 0 (
		choice /d N /t 30 /m �^�X�N�X�P�W���[���Ƀ^�X�N���쐬���܂����H
		if !errorlevel! equ 1 (
			powershell start-process "%~0" -verb runas
			exit
		)
	) else (
		echo. user: %USERNAME%
		schtasks /create /tn "snows\UAC�X���[" /tr "'%nowPath%%doApp%' $(Arg0) 1" /sc onevent /ec System /rl highest /F

		pause
	)
)