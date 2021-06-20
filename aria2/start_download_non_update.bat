@echo off
@echo ################################################
@echo #                                              #
@echo # aria2便捷下载脚本（不开启tracklist自动更新） #
@echo #                                              #
@echo #                  作者：直心                  #
@echo #                  版本：V2.1                  #
@echo #                  时间：2020年01月05日        #
@echo #                                              #
@echo ################################################


if exist %windir%\SysWOW64 (
    set sys=amd64
) ^
else (
    set sys=x86
)
if "%~1"=="" (
    set /p input="请输入下载文件的链接或bt种子的路径："
) ^
else (
    "%~dp0\core\%sys%\aria2c" "%~1" --conf-path="%~dp0\conf\aria2.conf" --dir="%~dp0\download" --dht-file-path6="%~dp0\dht\dht6.dat" --dht-file-path="%~dp0\dht\dht.dat"
)
if "%~1"=="" (
    set "input=%input:"=%"
)
if "%~1"=="" (
    "%~dp0\core\%sys%\aria2c" "%input%" --conf-path="%~dp0\conf\aria2.conf" --dir="%~dp0\download"  --dht-file-path6="%~dp0\dht\dht6.dat" --dht-file-path="%~dp0\dht\dht.dat"
)
pause
