@echo off
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"
@echo ##############################################
@echo #                                            #
@echo #              ѹ��������̽ű�              #
@echo #                                            #
@echo #                 ���ߣ�ֱ��                 #
@echo #                 �汾��V1.0                 #
@echo #                 ʱ�䣺2021��09��19��       #
@echo #                                            #
@echo ##############################################
@echo.
@echo.

if exist compact.ps1 (del compact.ps1)

::������
:f1
set /p input="������Ҫѹ������������ļ���vhd/vhdx����·����"
for %%a in (%input%) do set input=%%~a
if not exist "%input%" (
    @echo �ļ����ļ��е�·�������ڣ�������������롣
    goto f1
)
@echo ѹ����ʼ
echo Mount-VHD -Path "%input%" -ReadOnly > .\compact.ps1
echo Optimize-VHD -Path "%input%" -Mode Full >> .\compact.ps1
echo Dismount-VHD "%input%" >> .\compact.ps1
powershell .\compact.ps1
del .\compact.ps1

@echo ѹ�����
pause