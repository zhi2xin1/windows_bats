@echo off
@echo ##############################################
@echo #                                            #
@echo #          tar-lz4 便捷压缩/解压脚本         #
@echo #                                            #
@echo #                 作者：直心                 #
@echo #                 版本：V2.0                 #
@echo #                 时间：2021年08月29日       #
@echo #                                            #
@echo ##############################################

if exist "%windir%\SysWOW64" (
    set sys=amd64
) ^
else (
    set sys=x86
)
@echo.
@echo.

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
    set input_endwith2=%%~xa
)
for %%a in ("%output_name%") do (
    set input_endwith1=%%~xa
)
set input_endwith=%input_endwith1%%input_endwith2%
if "%input_endwith%"==".tar.lz4" (
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
    "%~dp0\%sys%\lz4" "%input%" | "%~dp0\%sys%\7za" x -y -o"%output%" -ttar -si
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\lz4" "%input%" | "%~dp0\%sys%\7za" x -y -o"%output%" -ttar -si
) ^
else (
    "%~dp0\%sys%\lz4" "%input%" | "%~dp0\%sys%\7za" x -o"%output%" -ttar -si
)
goto mode0_end
:mode0_co
set /p outputa="请输入要保存压缩后得到的文件的路径（留空表示压缩到与输入目录 * 上级目录下的 *.tar.lz4）:"
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
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%input%" | "%~dp0\%sys%\lz4" -f - "%output%\%output_name%.tar.lz4"
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%input%" | "%~dp0\%sys%\lz4" -f - "%output%\%output_name%.tar.lz4"
) ^
else (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%input%" | "%~dp0\%sys%\lz4" - "%output%\%output_name%.tar.lz4"
)
goto :mode0_end
:mode0_end
goto :end

@REM 拖入的情况
:mode1
for %%a in ("%~1") do (
    set output_fold=%%~dpa
    set output_name=%%~na
    set input_endwith2=%%~xa
)
for %%a in ("%output_name%") do (
    set input_endwith1=%%~xa
)
set input_endwith=%input_endwith1%%input_endwith2%
if "%input_endwith%"==".tar.lz4" (
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
    "%~dp0\%sys%\lz4" "%~1" | "%~dp0\%sys%\7za" x -y -o"%output%" -ttar -si
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\lz4" "%~1" | "%~dp0\%sys%\7za" x -y -o"%output%" -ttar -si
) ^
else (
    "%~dp0\%sys%\lz4" "%~1" | "%~dp0\%sys%\7za" x -o"%output%" -ttar -si
)
goto mode1_end
:mode1_co
set /p outputa="请输入要保存压缩后得到的文件的路径（留空表示压缩到与输入目录 * 上级目录下的 *.tar.lz4）:"
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
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%~1" | "%~dp0\%sys%\lz4" -f - "%output%\%output_name%.tar.lz4"
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%~1" | "%~dp0\%sys%\lz4" -f - "%output%\%output_name%.tar.lz4"
) ^
else (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%~1" | "%~dp0\%sys%\lz4" - "%output%\%output_name%.tar.lz4"
)
goto :mode1_end
:mode1_end
goto :end

:end
pause
