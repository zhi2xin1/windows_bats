@echo off
title tar-zstd-openssl ��ݼӽ��ܼӽ�ѹ�ű�
@echo ##############################################
@echo #                                            #
@echo #   tar-zstd-openssl ��ݼӽ��ܼӽ�ѹ�ű�    #
@echo #                                            #
@echo #                 ���ߣ�ֱ��                 #
@echo #                 �汾��V2.2                #
@echo #                 ʱ�䣺2022��04��19��       #
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
set /p input="������Ҫ������ļ����ļ��е�·����"
for %%a in (%input%) do set input=%%~a
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

@REM set input_endwith=%input_endwith1%%input_endwith2%%input_endwith3%
if "%input_endwith1%"==".tar" (
    if "%input_endwith2%"==".zst" (
        if "%input_endwith3%"==".aes-256-ctr"   (
            goto mode0_de_enc
        )
    )
) ^
else if "%input_endwith2%"==".tar" (
    if "%input_endwith3%"==".zst" (
        goto mode0_de
    )
) ^
else (
    goto mode0_co
)
:mode0_de
set /p outputa="������Ҫ��ѹ�����ļ���·�������ձ�ʾ��ѹ����ѹ���� *.tar.zst ͬĿ¼�µ��� * ͬ������Ŀ¼��:"
for %%a in (%outputa%) do set outputa=%%~a
if "%outputa%"=="" (
    set output=%output_fold%
) ^
else (
    set output=%outputa%
)
if not exist "%output%" (
    @echo �ļ����ļ��е�·�������ڣ�������������롣
    goto mode0_de
)
set /p overwrite="������ļ����ظ����ļ��Ƿ�Ҫ�ý�ѹ�������ļ��滻���ǣ������� Y ��ʾҪ�� N ��ʾ��Ҫ��Ĭ�ϲ�Ҫ��"
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\zstd" -dc "%input%" | "%~dp0\%sys%\7za" x -aoa -o"%output%" -ttar -si
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\zstd" -dc "%input%" | "%~dp0\%sys%\7za" x -aoa -o"%output%" -ttar -si
) ^
else (
    "%~dp0\%sys%\zstd" -dc "%input%" | "%~dp0\%sys%\7za" x -aos -o"%output%" -ttar -si
)
goto mode0_end
:mode0_de_enc
set /p outputa="������Ҫ��ѹ�����ļ���·�������ձ�ʾ��ѹ����ѹ���� *.tar.zst.aes-256-ctr ͬĿ¼�µ��� * ͬ������Ŀ¼��:"
for %%a in (%outputa%) do set outputa=%%~a
if "%outputa%"=="" (
    set output=%output_fold%
) ^
else (
    set output=%outputa%
)
if not exist "%output%" (
    @echo �ļ����ļ��е�·�������ڣ�������������롣
    goto mode0_de_enc
)
set /p overwrite="������ļ����ظ����ļ��Ƿ�Ҫ�ý�ѹ�������ļ��滻���ǣ������� Y ��ʾҪ�� N ��ʾ��Ҫ��Ĭ�ϲ�Ҫ��"
set /p password="������ѹ���ļ������룺"
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -d -pass pass:%password% -pbkdf2 -in "%input%" | "%~dp0\%sys%\zstd"  -dc - | "%~dp0\%sys%\7za" x -aos -o"%output%" -ttar -si
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -d -pass pass:%password% -pbkdf2 -in "%input%" | "%~dp0\%sys%\zstd"  -dc - | "%~dp0\%sys%\7za" x -aos -o"%output%" -ttar -si
) ^
else (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -d -pass pass:%password% -pbkdf2 -in "%input%" | "%~dp0\%sys%\zstd"  -dc - | "%~dp0\%sys%\7za" x -aoa -o"%output%" -ttar -si
)
goto mode0_end
:mode0_co
set /p outputa="������Ҫ����ѹ����õ����ļ��е�·�������ձ�ʾѹ����������Ŀ¼ * �ϼ�Ŀ¼�µ� *.tar.zst.aes-256-ctr�����ܣ����� *.tar.zst�������ܣ���:"
for %%a in (%outputa%) do set outputa=%%~a
if "%outputa%"=="" (
    set output=%output_fold%
) ^
else (
    set output=%outputa%
)
if not exist "%output%" (
    @echo �ļ����ļ��е�·�������ڣ�������������롣
    goto mode0_co
)
set /p overwrite="������ļ����ظ����ļ��Ƿ�Ҫ��ѹ����õ����ļ��滻���ǣ������� Y ��ʾҪ�� N ��ʾ��Ҫ��Ĭ�ϲ�Ҫ��"
set /p password="������ѹ���ļ������루���ձ�ʾ�����ܣ���"
if "%password%"=="" (
    goto mode0_co_non
)
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%input%" | "%~dp0\%sys%\zstd" -T0 -f -v | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.zst.aes-256-ctr"
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%input%" | "%~dp0\%sys%\zstd" -T0 -f -v | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.zst.aes-256-ctr"
) ^
else if not exist "%output%\%output_name%.tar.zst.aes-256-ctr" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%input%" | "%~dp0\%sys%\zstd" -T0 -f -v | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.zst.aes-256-ctr"
) ^
else (
    @echo "�ļ��Ѿ����ڣ�"
)
goto :mode0_end
:mode0_co_non
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%input%" | "%~dp0\%sys%\zstd" -T0 -f -v -o "%output%\%output_name%.tar.zst"
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%input%" | "%~dp0\%sys%\zstd" -T0 -f -v -o "%output%\%output_name%.tar.zst"
) ^
else (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%input%" | "%~dp0\%sys%\zstd" -T0 -v -o "%output%\%output_name%.tar.zst"
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
@REM set input_endwith=%input_endwith1%%input_endwith2%%input_endwith3%
if "%input_endwith1%"==".tar" (
    if "%input_endwith2%"==".zst" (
        if "%input_endwith3%"==".aes-256-ctr"   (
            goto mode1_de_enc
        )
    )
) ^
else if "%input_endwith2%"==".tar" (
    if "%input_endwith3%"==".zst" (
        goto mode1_de
    )
) ^
else (
    goto mode1_co
)
:mode1_de
set /p outputa="������Ҫ��ѹ�����ļ���·�������ձ�ʾ��ѹ����ѹ���� *.tar.zst ͬĿ¼�µ��� * ͬ������Ŀ¼��:"
for %%a in (%outputa%) do set outputa=%%~a
if "%outputa%"=="" (
    set output=%output_fold%
) ^
else (
    set output=%outputa%
)
if not exist "%output%" (
    @echo �ļ����ļ��е�·�������ڣ�������������롣
    goto mode1_de
)
set /p overwrite="������ļ����ظ����ļ��Ƿ�Ҫ�ý�ѹ�������ļ��滻���ǣ������� Y ��ʾҪ�� N ��ʾ��Ҫ��Ĭ�ϲ�Ҫ��"
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\zstd" -dc "%~1" | "%~dp0\%sys%\7za" x -aoa -o"%output%" -ttar -si
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\zstd" -dc "%~1" | "%~dp0\%sys%\7za" x -aoa -o"%output%" -ttar -si
) ^
else (
    "%~dp0\%sys%\zstd" -dc "%~1" | "%~dp0\%sys%\7za" x -aos -o"%output%" -ttar -si
)
goto mode1_end
:mode1_de_enc
set /p outputa="������Ҫ��ѹ�����ļ���·�������ձ�ʾ��ѹ����ѹ���� *.tar.zst.aes-256-ctr ͬĿ¼�µ��� * ͬ������Ŀ¼��:"
for %%a in (%outputa%) do set outputa=%%~a
if "%outputa%"=="" (
    set output=%output_fold%
) ^
else (
    set output=%outputa%
)
if not exist "%output%" (
    @echo �ļ����ļ��е�·�������ڣ�������������롣
    goto mode1_de_enc
)
set /p overwrite="������ļ����ظ����ļ��Ƿ�Ҫ�ý�ѹ�������ļ��滻���ǣ������� Y ��ʾҪ�� N ��ʾ��Ҫ��Ĭ�ϲ�Ҫ��"
set /p password="������ѹ���ļ������룺"
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -d -pass pass:%password% -pbkdf2 -in "%~1" | "%~dp0\%sys%\zstd"  -dc - | "%~dp0\%sys%\7za" x -aos -o"%output%" -ttar -si 
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -d -pass pass:%password% -pbkdf2 -in "%~1" | "%~dp0\%sys%\zstd"  -dc - | "%~dp0\%sys%\7za" x -aos -o"%output%" -ttar -si 
) ^
else (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -d -pass pass:%password% -pbkdf2 -in "%~1" | "%~dp0\%sys%\zstd"  -dc - | "%~dp0\%sys%\7za" x -aoa -o"%output%" -ttar -si 
)
goto mode1_end
:mode1_co
set /p outputa="������Ҫ����ѹ����õ����ļ��е�·�������ձ�ʾѹ����������Ŀ¼ * �ϼ�Ŀ¼�µ� *.tar.zst.aes-256-ctr�����ܣ����� *.tar.zst�������ܣ���:"
for %%a in (%outputa%) do set outputa=%%~a
if "%outputa%"=="" (
    set output=%output_fold%
) ^
else (
    set output=%outputa%
)
if not exist "%output%" (
    @echo �ļ����ļ��е�·�������ڣ�������������롣
    goto mode1_co
)
set /p overwrite="������ļ����ظ����ļ��Ƿ�Ҫ��ѹ����õ����ļ��滻���ǣ������� Y ��ʾҪ�� N ��ʾ��Ҫ��Ĭ�ϲ�Ҫ��"
set /p password="������ѹ���ļ������루���ձ�ʾ�����ܣ���"
if "%password%"=="" (
    goto mode1_co_non
)
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%~1" | "%~dp0\%sys%\zstd" -T0 -f -v | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.zst.aes-256-ctr"
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%~1" | "%~dp0\%sys%\zstd" -T0 -f -v | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.zst.aes-256-ctr"
) ^
else if not exist "%output%\%output_name%.tar.zst.aes-256-ctr" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%~1" | "%~dp0\%sys%\zstd" -T0 -f -v | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.zst.aes-256-ctr"
) ^
else (
    @echo "�ļ��Ѿ����ڣ�"
)
goto :mode1_end
:mode1_co_non
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%~1" | "%~dp0\%sys%\zstd" -T0 -f -v -o "%output%\%output_name%.tar.zst"
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%~1" | "%~dp0\%sys%\zstd" -T0 -f -v -o "%output%\%output_name%.tar.zst"
) ^
else (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%~1" | "%~dp0\%sys%\zstd" -T0 -v -o "%output%\%output_name%.tar.zst"
)
goto :mode1_end
:mode1_end
goto :end

:end

@echo �������
pause