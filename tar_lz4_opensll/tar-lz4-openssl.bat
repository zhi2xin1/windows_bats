@echo off
title tar-lz4-openssl 便捷加解密加解压脚本
@echo ##############################################
@echo #                                            #
@echo #    tar-lz4-openssl 便捷加解密加解压脚本    #
@echo #                                            #
@echo #                 作者：直心                 #
@echo #                 版本：V2.0                 #
@echo #                 时间：2021年08月29日       #
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

@REM 非拖入的情况
:mode0
:input_again
set /p input="请输入要处理的文件或文件夹的路径："
for %%a in (%input%) do set input=%%~a
if not exist "%input%" (
    @echo 文件或文件夹的路径不存在，请检查后重新输入。
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
if "%input_endwith%"==".tar.lz4.aes-256-ctr" (
    goto mode0_de_enc
) ^
else if "%input_endwith%"==".tar.lz4" (
    goto mode0_de
) ^
else (
    goto mode0_co
)
:mode0_de
set /p outputa="请输入要解压到的文件夹路径（留空表示解压到与压缩包 *.tar.lz4 同目录下的与 * 同名的子目录）:"
for %%a in (%outputa%) do set outputa=%%~a
if "%outputa%"=="" (
    set output=%output_fold%
) ^
else (
    set output=%outputa%
)
if not exist "%output%" (
    @echo 文件或文件夹的路径不存在，请检查后重新输入。
    goto mode0_de
)
set /p overwrite="如果有文件名重复的文件是否要用解压出来的文件替换他们？（输入 Y 表示要， N 表示不要，默认不要）"
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\lz4" -dc "%input%" | "%~dp0\%sys%\7za" x -aoa -o"%output%" -ttar -si
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\lz4" -dc "%input%" | "%~dp0\%sys%\7za" x -aoa -o"%output%" -ttar -si
) ^
else (
    "%~dp0\%sys%\lz4" -dc "%input%" | "%~dp0\%sys%\7za" x -aos -o"%output%" -ttar -si
)
goto mode0_end
:mode0_de_enc
set /p outputa="请输入要解压到的文件夹路径（留空表示解压到与压缩包 *.tar.lz4.aes-256-ctr 同目录下的与 * 同名的子目录）:"
for %%a in (%outputa%) do set outputa=%%~a
if "%outputa%"=="" (
    set output=%output_fold%
) ^
else (
    set output=%outputa%
)
if not exist "%output%" (
    @echo 文件或文件夹的路径不存在，请检查后重新输入。
    goto mode0_de_enc
)
set /p overwrite="如果有文件名重复的文件是否要用解压出来的文件替换他们？（输入 Y 表示要， N 表示不要，默认不要）"
set /p password="请输入压缩文件的密码："
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -d -pass pass:%password% -pbkdf2 -in "%input%" | "%~dp0\%sys%\lz4"  -dc - | "%~dp0\%sys%\7za" x -aos -o"%output%" -ttar -si
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -d -pass pass:%password% -pbkdf2 -in "%input%" | "%~dp0\%sys%\lz4"  -dc - | "%~dp0\%sys%\7za" x -aos -o"%output%" -ttar -si
) ^
else (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -d -pass pass:%password% -pbkdf2 -in "%input%" | "%~dp0\%sys%\lz4"  -dc - | "%~dp0\%sys%\7za" x -aoa -o"%output%" -ttar -si
)
goto mode0_end
:mode0_co
set /p outputa="请输入要保存压缩后得到的文件夹的路径（留空表示压缩到与输入目录 * 上级目录下的 *.tar.lz4.aes-256-ctr（加密）或者 *.tar.lz4（不加密））:"
for %%a in (%outputa%) do set outputa=%%~a
if "%outputa%"=="" (
    set output=%output_fold%
) ^
else (
    set output=%outputa%
)
if not exist "%output%" (
    @echo 文件或文件夹的路径不存在，请检查后重新输入。
    goto mode0_co
)
set /p overwrite="如果有文件名重复的文件是否要用压缩后得到的文件替换他们？（输入 Y 表示要， N 表示不要，默认不要）"
set /p password="请输入压缩文件的密码（留空表示不加密）："
if "%password%"=="" (
    goto mode0_co_non
)
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%input%" | "%~dp0\%sys%\lz4" -fcv | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.lz4.aes-256-ctr"
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%input%" | "%~dp0\%sys%\lz4" -fcv | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.lz4.aes-256-ctr"
) ^
else if not exist "%output%\%output_name%.tar.lz4.aes-256-ctr" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%input%" | "%~dp0\%sys%\lz4" -fcv | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.lz4.aes-256-ctr"
) ^
else (
    @echo "文件已经存在！"
)
goto :mode0_end
:mode0_co_non
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%input%" | "%~dp0\%sys%\lz4" -f -v - "%output%\%output_name%.tar.lz4"
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%input%" | "%~dp0\%sys%\lz4" -f -v - "%output%\%output_name%.tar.lz4"
) ^
else (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%input%" | "%~dp0\%sys%\lz4" -v - "%output%\%output_name%.tar.lz4"
)
goto :mode0_end
:mode0_end
goto :end

@REM 拖入的情况
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
if "%input_endwith%"==".tar.lz4.aes-256-ctr" (
    goto mode1_de_enc
) ^
else if "%input_endwith%"==".tar.lz4" (
    goto mode1_de
) ^
else (
    goto mode1_co
)
:mode1_de
set /p outputa="请输入要解压到的文件夹路径（留空表示解压到与压缩包 *.tar.lz4 同目录下的与 * 同名的子目录）:"
for %%a in (%outputa%) do set outputa=%%~a
if "%outputa%"=="" (
    set output=%output_fold%
) ^
else (
    set output=%outputa%
)
if not exist "%output%" (
    @echo 文件或文件夹的路径不存在，请检查后重新输入。
    goto mode1_de
)
set /p overwrite="如果有文件名重复的文件是否要用解压出来的文件替换他们？（输入 Y 表示要， N 表示不要，默认不要）"
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\lz4" -dc "%~1" | "%~dp0\%sys%\7za" x -aoa -o"%output%" -ttar -si
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\lz4" -dc "%~1" | "%~dp0\%sys%\7za" x -aoa -o"%output%" -ttar -si
) ^
else (
    "%~dp0\%sys%\lz4" -dc "%~1" | "%~dp0\%sys%\7za" x -aos -o"%output%" -ttar -si
)
goto mode1_end
:mode1_de_enc
set /p outputa="请输入要解压到的文件夹路径（留空表示解压到与压缩包 *.tar.lz4.aes-256-ctr 同目录下的与 * 同名的子目录）:"
for %%a in (%outputa%) do set outputa=%%~a
if "%outputa%"=="" (
    set output=%output_fold%
) ^
else (
    set output=%outputa%
)
if not exist "%output%" (
    @echo 文件或文件夹的路径不存在，请检查后重新输入。
    goto mode1_de_enc
)
set /p overwrite="如果有文件名重复的文件是否要用解压出来的文件替换他们？（输入 Y 表示要， N 表示不要，默认不要）"
set /p password="请输入压缩文件的密码："
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -d -pass pass:%password% -pbkdf2 -in "%~1" | "%~dp0\%sys%\lz4"  -dc - | "%~dp0\%sys%\7za" x -aos -o"%output%" -ttar -si 
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -d -pass pass:%password% -pbkdf2 -in "%~1" | "%~dp0\%sys%\lz4"  -dc - | "%~dp0\%sys%\7za" x -aos -o"%output%" -ttar -si 
) ^
else (
    "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -d -pass pass:%password% -pbkdf2 -in "%~1" | "%~dp0\%sys%\lz4"  -dc - | "%~dp0\%sys%\7za" x -aoa -o"%output%" -ttar -si 
)
goto mode1_end
:mode1_co
set /p outputa="请输入要保存压缩后得到的文件夹的路径（留空表示压缩到与输入目录 * 上级目录下的 *.tar.lz4.aes-256-ctr（加密）或者 *.tar.lz4（不加密））:"
for %%a in (%outputa%) do set outputa=%%~a
if "%outputa%"=="" (
    set output=%output_fold%
) ^
else (
    set output=%outputa%
)
if not exist "%output%" (
    @echo 文件或文件夹的路径不存在，请检查后重新输入。
    goto mode1_co
)
set /p overwrite="如果有文件名重复的文件是否要用压缩后得到的文件替换他们？（输入 Y 表示要， N 表示不要，默认不要）"
set /p password="请输入压缩文件的密码（留空表示不加密）："
if "%password%"=="" (
    goto mode1_co_non
)
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%~1" | "%~dp0\%sys%\lz4" -fcv | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.lz4.aes-256-ctr"
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%~1" | "%~dp0\%sys%\lz4" -fcv | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.lz4.aes-256-ctr"
) ^
else if not exist "%output%\%output_name%.tar.lz4.aes-256-ctr" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so "%~1" | "%~dp0\%sys%\lz4" -fcv | "%~dp0\%sys%\OpenSSL\bin\openssl.exe" enc -aes-256-ctr -e -pass pass:%password% -pbkdf2 -in - -out "%output%\%output_name%.tar.lz4.aes-256-ctr"
) ^
else (
    @echo "文件已经存在！"
)
goto :mode1_end
:mode1_co_non
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%~1" | "%~dp0\%sys%\lz4" -f -v - "%output%\%output_name%.tar.lz4"
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%~1" | "%~dp0\%sys%\lz4" -f -v - "%output%\%output_name%.tar.lz4"
) ^
else (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%~1" | "%~dp0\%sys%\lz4" -v - "%output%\%output_name%.tar.lz4"
)
goto :mode1_end
:mode1_end
goto :end

:end

@echo 处理完成
pause