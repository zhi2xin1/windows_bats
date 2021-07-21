@echo off
title tar-zstd-openssl ��ݼӽ��ܼӽ�ѹ�ű�
@echo ##############################################
@echo #                                            #
@echo #   tar-zstd-openssl ��ݼӽ��ܼӽ�ѹ�ű�    #
@echo #                                            #
@echo #                 ���ߣ�ֱ��                 #
@echo #                 �汾��V1.0                 #
@echo #                 ʱ�䣺2021��07��21��       #
@echo #                                            #
@echo ##############################################
@echo.
@echo.

if exist "%windir%\SysWOW64" (
    set sys=amd64
) ^
else (
    set sys=x86
)

if "%~1"=="" (
    goto mode0
 ) ^
 else (
    goto mode1
 )

@REM ����������
:mode0
:input_again
set /p input="������Ҫ��ѹ�����ļ����ļ��е�·����"
for %%a in ("%input%") do set input=%%~a
@echo %input%
if not exist "%input%" (
    @echo �ļ����ļ��е�·�������ڣ�������������롣
    goto input_again
)
for %%a in ("%input%") do (
    set output_fold=%%~dpa
    set output_name=%%~na
    set input_endwith3=%%~xa
)
for %%a in ("%output_name%") do (
    set output_name=%%~na
    set input_endwith2=%%~xa
)
for %%a in ("%output_name%") do (
    set input_endwith1=%%~xa
)
set input_endwith=%input_endwith1%%input_endwith2%%input_endwith3%
if "%input_endwith%"==".tar.zst.aes-256-cbc" (
    goto mode0_de
) ^
else (
    goto mode0_co
)
:mode0_de
set /p outputa="������Ҫ��ѹ�����ļ���·�������ձ�ʾ��ѹ����ѹ���� *.tar.zst.aes-256-cbc ͬĿ¼�µ��� * ͬ������Ŀ¼��:"
if "%outputa%"=="" (
    set output=%output_fold%
) ^
else (
    set output=%outputa%
)
set /p overwrite="������ļ����ظ����ļ��Ƿ�Ҫ�ý�ѹ�������ļ��滻���ǣ������� Y ��ʾҪ�� N ��ʾ��Ҫ��Ĭ�ϲ�Ҫ��"
set /p password="������ѹ���ļ������룺"
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-cbc -d -pass pass:%password% -pbkdf2 -in "%input%" | "%~dp0\%sys%\zstd"  -d - | "%~dp0\%sys%\7za" x -aos -o"%output%" -ttar -si
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-cbc -d -pass pass:%password% -pbkdf2 -in "%input%" | "%~dp0\%sys%\zstd"  -d - | "%~dp0\%sys%\7za" x -aos -o"%output%" -ttar -si
) ^
else (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-cbc -d -pass pass:%password% -pbkdf2 -in "%input%" | "%~dp0\%sys%\zstd"  -d - | "%~dp0\%sys%\7za" x -aoa -o"%output%" -ttar -si
)
goto mode0_end
:mode0_co
set /p outputa="������Ҫ����ѹ����õ����ļ���·�������ձ�ʾѹ����������Ŀ¼ * �ϼ�Ŀ¼�µ� *.tar.zst.aes-256-cbc��:"
if "%outputa%"=="" (
    set output=%output_fold%
) ^
else (
    set output=%outputa%
)
set /p overwrite="������ļ����ظ����ļ��Ƿ�Ҫ��ѹ����õ����ļ��滻���ǣ������� Y ��ʾҪ�� N ��ʾ��Ҫ��Ĭ�ϲ�Ҫ��"
set /p password="������ѹ���ļ������룺"
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%input%" | "%~dp0\%sys%\zstd" -T0 -f -v | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-cbc -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.zst.aes-256-cbc"
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%input%" | "%~dp0\%sys%\zstd" -T0 -f -v | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-cbc -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.zst.aes-256-cbc"
) ^
else if not exist "%output%\%output_name%.tar.zst.aes-256-cbc" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%input%" | "%~dp0\%sys%\zstd" -T0 -f -v | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-cbc -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.zst.aes-256-cbc"
) ^
else (
    @echo "�ļ��Ѿ����ڣ�"
)
goto :mode0_end
:mode0_end
goto :end

@REM ��������
:mode1
for %%a in ("%~1") do (
    set output_fold=%%~dpa
    set output_name=%%~na
    set input_endwith3=%%~xa
)
for %%a in ("%output_name%") do (
    set output_name=%%~na
    set input_endwith2=%%~xa
)
for %%a in ("%output_name%") do (
    set input_endwith1=%%~xa
)
set input_endwith=%input_endwith1%%input_endwith2%%input_endwith3%
if "%input_endwith%"==".tar.zst.aes-256-cbc" (
    goto mode1_de
) ^
else (
    goto mode1_co
)
:mode1_de
set /p outputa="������Ҫ��ѹ�����ļ���·�������ձ�ʾ��ѹ����ѹ���� *.tar.zst.aes-256-cbc ͬĿ¼�µ��� * ͬ������Ŀ¼��:"
if "%outputa%"=="" (
    set output=%output_fold%
) ^
else (
    set output=%outputa%
)
set /p overwrite="������ļ����ظ����ļ��Ƿ�Ҫ�ý�ѹ�������ļ��滻���ǣ������� Y ��ʾҪ�� N ��ʾ��Ҫ��Ĭ�ϲ�Ҫ��"
set /p password="������ѹ���ļ������룺"
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-cbc -d -pass pass:%password% -pbkdf2 -in "%~1" | "%~dp0\%sys%\zstd"  -d - | "%~dp0\%sys%\7za" x -aos -o"%output%" -ttar -si 
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-cbc -d -pass pass:%password% -pbkdf2 -in "%~1" | "%~dp0\%sys%\zstd"  -d - | "%~dp0\%sys%\7za" x -aos -o"%output%" -ttar -si 
) ^
else (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-cbc -d -pass pass:%password% -pbkdf2 -in "%~1" | "%~dp0\%sys%\zstd"  -d - | "%~dp0\%sys%\7za" x -aoa -o"%output%" -ttar -si 
)
goto mode1_end
:mode1_co
set /p outputa="������Ҫ����ѹ����õ����ļ���·�������ձ�ʾѹ����������Ŀ¼ * �ϼ�Ŀ¼�µ� *.tar.zst.aes-256-cbc��:"
if "%outputa%"=="" (
    set output=%output_fold%
) ^
else (
    set output=%outputa%
)
set /p overwrite="������ļ����ظ����ļ��Ƿ�Ҫ��ѹ����õ����ļ��滻���ǣ������� Y ��ʾҪ�� N ��ʾ��Ҫ��Ĭ�ϲ�Ҫ��"
set /p password="������ѹ���ļ������룺"
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%~1" | "%~dp0\%sys%\zstd" -T0 -f -v | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-cbc -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.zst.aes-256-cbc"
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%~1" | "%~dp0\%sys%\zstd" -T0 -f -v | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-cbc -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.zst.aes-256-cbc"
) ^
else if not exist "%output%\%output_name%.tar.zst.aes-256-cbc" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%~1" | "%~dp0\%sys%\zstd" -T0 -f -v | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-cbc -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.zst.aes-256-cbc"
) ^
else (
    @echo "�ļ��Ѿ����ڣ�"
)
goto :mode1_end
:mode1_end
goto :end

:end

@echo �������
pause