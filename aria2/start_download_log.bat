@echo off
@echo ##############################################
@echo #                                            #
@echo #      aria2������ؽű���������־��¼��     #
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
if "%~1"=="" (
    set /p input="�����������ļ������ӻ�bt���ӵ�·����"
) ^
else (
    "%~dp0\core\%sys%\aria2c" "%~1" --conf-path="%~dp0\conf\aria2.conf" --dir="%~dp0\download" --dht-file-path6="%~dp0\dht\dht6.dat" --dht-file-path="%~dp0\dht\dht.dat" --log="%~dp0\log"
)
if "%~1"=="" (
    set "input=%input:"=%"
)
if "%~1"=="" (
    "%~dp0\core\%sys%\aria2c" "%input%" --conf-path="%~dp0\conf\aria2.conf" --dir="%~dp0\download"  --dht-file-path6="%~dp0\dht\dht6.dat" --dht-file-path="%~dp0\dht" --log="%~dp0\log"
)
pause
