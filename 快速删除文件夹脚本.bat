@echo off
@echo ##############################################
@echo #                                            #
@echo #             ����ɾ���ļ��нű�             #
@echo #                                            #
@echo #                 ���ߣ�ֱ��                 #
@echo #                 �汾��V1.0                 #
@echo #                 ʱ�䣺2021��06��20��       #
@echo #                                            #
@echo ##############################################
@echo.
@echo.
if "%~1"=="" (
    set /p input="������Ҫɾ�����ļ��е�·����"
) ^
else (
    @echo ɾ����ʼ
    del /f/s/q "%~1" > nul
    rmdir /s/q "%~1"
)
if "%~1"=="" (
    set "input=%input:"=%"
)
if "%~1"=="" (
    @echo ɾ����ʼ
    del /f/s/q "%input%" > nul
    rmdir /s/q "%input%"
)
@echo ɾ�����
pause