@echo off
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"
@echo ##############################################
@echo #                                            #
@echo #              压缩虚拟磁盘脚本              #
@echo #                                            #
@echo #                 作者：直心                 #
@echo #                 版本：V1.0                 #
@echo #                 时间：2021年09月19日       #
@echo #                                            #
@echo ##############################################
@echo.
@echo.

if exist compact.ps1 (del compact.ps1)

::非拖入
:f1
set /p input="请输入要压缩的虚拟磁盘文件（vhd/vhdx）的路径："
for %%a in (%input%) do set input=%%~a
if not exist "%input%" (
    @echo 文件或文件夹的路径不存在，请检查后重新输入。
    goto f1
)
@echo 压缩开始
echo Mount-VHD -Path "%input%" -ReadOnly > .\compact.ps1
echo Optimize-VHD -Path "%input%" -Mode Full >> .\compact.ps1
echo Dismount-VHD "%input%" >> .\compact.ps1
powershell .\compact.ps1
del .\compact.ps1

@echo 压缩完成
pause