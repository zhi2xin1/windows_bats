@echo off
@echo ##############################################
@echo #                                            #
@echo #           清理系统图标缓存数据库           #
@echo #                                            #
@echo #                 作者：直心                 #
@echo #                 版本：V1.0                 #
@echo #                 时间：2021年06月20日       #
@echo #                                            #
@echo ##############################################
@echo.
@echo.
pause
@echo 关闭Windows外壳程序explorer

taskkill /f /im explorer.exe

@echo 清理系统图标缓存数据库

attrib -h -s -r "%userprofile%\AppData\Local\IconCache.db"

del /f "%userprofile%\AppData\Local\IconCache.db"

attrib /s /d -h -s -r "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\*"

del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_32.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_96.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_102.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_256.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_1024.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_idx.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_sr.db"

@echo 清理 系统托盘记忆的图标

echo y|reg delete "HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v IconStreams
echo y|reg delete "HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v PastIconsStream

@echo 重启Windows外壳程序explorer

start explorer

@echo 清理完成
pause