@echo off
@echo ##############################################
@echo #                                            #
@echo #              aria2������ؽű�             #
@echo #                                            #
@echo #                 ���ߣ�ֱ��                 #
@echo #                 �汾��V2.1                 #
@echo #                 ʱ�䣺2020��01��05��       #
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
@echo track list ���¿�ʼ
:: aria2.confλ�á�Ҫ���ص�trackers�ļ����������޸�
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
@echo track list�������
@echo.
@echo.


if "%~1"=="" (
    set /p input="�����������ļ������ӻ�bt���ӵ�·����"
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
