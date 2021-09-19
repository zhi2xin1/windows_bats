@echo off
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

if exist compact.txt (del compact.txt)
if not "%~1"=="" (goto f2)

::非拖入
:f1
set /p input="请输入要压缩的虚拟磁盘文件（vhd/vhdx）的路径："
for %%a in (%input%) do set input=%%~a
if not exist "%input%" (
    @echo 文件或文件夹的路径不存在，请检查后重新输入。
    goto f1
)
@echo 压缩开始
echo select vdisk file="%input%" > compact.txt
goto end

::拖入
:f2
@echo 压缩开始
echo select vdisk file="%input%" > compact.txt

:end
echo compact vdisk >> compact.txt
diskpart /s compact.txt
del compact.txt

@echo 压缩完成
pause