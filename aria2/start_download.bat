@echo off
@echo ##############################################
@echo #                                            #
@echo #              aria2便捷下载脚本             #
@echo #                                            #
@echo #                 作者：直心                 #
@echo #                 版本：V2.1                 #
@echo #                 时间：2020年01月05日       #
@echo #                                            #
@echo ##############################################


if exist %windir%\SysWOW64 (
    set sys=amd64
) ^
else (
    set sys=x86
)
@echo.
@echo.
@echo track list 更新开始
:: aria2.conf位置、要下载的trackers文件，在这里修改
set CONF_FILE=%~dp0\conf\aria2.conf
set TRACKER_FILE=all_aria2.txt
set DOWNLOAD_LINK=https://trackerslist.com/%TRACKER_FILE%

"%~dp0\core\%sys%\aria2c" --dir="%~dp0\download" --allow-overwrite=true "%DOWNLOAD_LINK%"

"%~dp0\core\sed\bin\sed" -i ":a;N;s/\n/ /; ta;" "%~dp0\download\%TRACKER_FILE%"
"%~dp0\core\sed\bin\sed" -i "1s/^/bt-tracker=/g; s/  /,/g; s/ $//;" "%~dp0\download\%TRACKER_FILE%"
"%~dp0\core\sed\bin\sed" -i "/^bt-tracker=/d" "%CONF_FILE%"

type "%~dp0\download\%TRACKER_FILE%" >> "%CONF_FILE%"
if "%~1"=="" (
    del "%~dp0\sed*"
) ^
else (
    del "%~dp1\sed*"
)
del "%~dp0\download\%TRACKER_FILE%"
@echo.
@echo track list更新完成
@echo.
@echo.


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
