@echo off
@echo ##############################################
@echo #                                            #
@echo #         tar-zstd ���ѹ��/��ѹ�ű�         #
@echo #                                            #
@echo #                 ���ߣ�ֱ��                 #
@echo #                 �汾��V2.0                 #
@echo #                 ʱ�䣺2021��08��29��       #
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
    set input_endwith2=%%~xa
)
for %%a in ("%output_name%") do (
    set input_endwith1=%%~xa
)
set input_endwith=%input_endwith1%%input_endwith2%
if "%input_endwith%"==".tar.zst" (
    goto mode0_de
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
    "%~dp0\%sys%\zstd" -dc "%input%" | "%~dp0\%sys%\7za" x -y -o"%output%" -ttar -si
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\zstd" -dc "%input%" | "%~dp0\%sys%\7za" x -y -o"%output%" -ttar -si
) ^
else (
    "%~dp0\%sys%\zstd" -dc "%input%" | "%~dp0\%sys%\7za" x -o"%output%" -ttar -si
)
goto mode0_end
:mode0_co
set /p outputa="������Ҫ����ѹ����õ����ļ���·�������ձ�ʾѹ����������Ŀ¼ * �ϼ�Ŀ¼�µ� *.tar.zst��:"
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
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%input%" | "%~dp0\%sys%\zstd" -T0 -f -o "%output%\%output_name%.tar.zst"
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%input%" | "%~dp0\%sys%\zstd" -T0 -f -o "%output%\%output_name%.tar.zst"
) ^
else (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%input%" | "%~dp0\%sys%\zstd" -T0 -o "%output%\%output_name%.tar.zst"
)
goto :mode0_end
:mode0_end
goto :end

@REM ��������
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
if "%input_endwith%"==".tar.zst" (
    goto mode1_de
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
    "%~dp0\%sys%\zstd" -dc "%~1" | "%~dp0\%sys%\7za" x -y -o"%output%" -ttar -si
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\zstd" -dc "%~1" | "%~dp0\%sys%\7za" x -y -o"%output%" -ttar -si
) ^
else (
    "%~dp0\%sys%\zstd" -dc "%~1" | "%~dp0\%sys%\7za" x -o"%output%" -ttar -si
)
goto mode1_end
:mode1_co
set /p outputa="������Ҫ����ѹ����õ����ļ���·�������ձ�ʾѹ����������Ŀ¼ * �ϼ�Ŀ¼�µ� *.tar.zst��:"
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
if "%overwrite%"=="Y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%~1" | "%~dp0\%sys%\zstd" -T0 -f -o "%output%\%output_name%.tar.zst"
) ^
else if "%overwrite%"=="y" (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%~1" | "%~dp0\%sys%\zstd" -T0 -f -o "%output%\%output_name%.tar.zst"
) ^
else (
    "%~dp0\%sys%\7za" a dummy -r -ttar -so  "%~1" | "%~dp0\%sys%\zstd" -T0 -o "%output%\%output_name%.tar.zst"
)
goto :mode1_end
:mode1_end
goto :end

:end
pause
