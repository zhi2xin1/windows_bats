@echo off

@echo ##############################################
@echo #                                            #
@echo #              aria2便捷下载脚本             #
@echo #                                            #
@echo #                 作者：直心                 #
@echo #                 版本：V2.4                 #
@echo #                 时间：2021年10月06日       #
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
set /p update="是否要更新 trackerslist ？（Y更新，N不更新，默认不更新）"
if not "%update%"=="Y" (
    if not "%update%"=="y" (
        goto derict_download
    )
)
@echo track list 更新开始
:: aria2.conf位置、要下载的trackers文件，在这里修改
set CONF_FILE=%~dp0\conf\aria2.conf
set TRACKER_FILE=all_aria2.txt
set DOWNLOAD_LINK=https://trackerslist.com/%TRACKER_FILE%

"%~dp0\core\%sys%\aria2c" --dir="%~dp0\download" --allow-overwrite=true "%DOWNLOAD_LINK%"

"%~dp0\core\%sys%\sed" -i ":a;N;s/\n/ /; ta;" "%~dp0\download\%TRACKER_FILE%"
"%~dp0\core\%sys%\sed" -i "1s/^/bt-tracker=/g; s/  /,/g; s/ $//;" "%~dp0\download\%TRACKER_FILE%"
"%~dp0\core\%sys%\sed" -i "/^bt-tracker=/d" "%CONF_FILE%"

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

:derict_download
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
