@echo off
@echo ##############################################
@echo #                                            #
@echo #              ѹ��������̽ű�              #
@echo #                                            #
@echo #                 ���ߣ�ֱ��                 #
@echo #                 �汾��V1.0                 #
@echo #                 ʱ�䣺2021��09��19��       #
@echo #                                            #
@echo ##############################################
@echo.
@echo.

if exist compact.txt (del compact.txt)
if not "%~1"=="" (goto f2)

::������
:f1
set /p input="������Ҫѹ������������ļ���vhd/vhdx����·����"
for %%a in (%input%) do set input=%%~a
if not exist "%input%" (
    @echo �ļ����ļ��е�·�������ڣ�������������롣
    goto f1
)
@echo ѹ����ʼ
echo select vdisk file="%input%" > compact.txt
goto end

::����
:f2
@echo ѹ����ʼ
echo select vdisk file="%input%" > compact.txt

:end
echo compact vdisk >> compact.txt
diskpart /s compact.txt
del compact.txt

@echo ѹ�����
pause