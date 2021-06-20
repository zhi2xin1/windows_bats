@echo off
@echo ##############################################
@echo #                                            #
@echo #             快速删除文件夹脚本             #
@echo #                                            #
@echo #                 作者：直心                 #
@echo #                 版本：V1.0                 #
@echo #                 时间：2021年06月20日       #
@echo #                                            #
@echo ##############################################
@echo.
@echo.
if "%~1"=="" (
    set /p input="请输入要删除的文件夹的路径："
) ^
else (
    @echo 删除开始
    del /f/s/q "%~1" > nul
    rmdir /s/q "%~1"
)
if "%~1"=="" (
    set "input=%input:"=%"
)
if "%~1"=="" (
    @echo 删除开始
    del /f/s/q "%input%" > nul
    rmdir /s/q "%input%"
)
@echo 删除完成
pause