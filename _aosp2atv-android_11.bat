@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
cls

title ATVKitchen

for /R %%f in (in\*.img) do (set filename=%%~nf)

if exist "%~1" (
  set in_filename=%~n1.img
  set out_filename=%~n1_atv.img
  set drop=1
) else (
  set in_filename=in\%filename%.img
  set out_filename=out\%filename%_atv.img
  set drop=0
)

if not exist "%in_filename%" exit

if exist level1 rmdir /q /s level1
md level1

Echo Firmware unpacking...
bin\AmlImagePack -d "%in_filename%" level1

if exist level2 rmdir /q /s level2
md level2

echo Convert super.img to super.img.raw
bin\simg2img level1\super.PARTITION level2\super.img.raw
echo Unpack super.img.raw
bin\lpunpack level2\super.img.raw level2 
echo Unpack odm_a.img
bin\imgextractor level2\odm_a.img level2\odm
echo Unpack product_a.img
bin\imgextractor level2\product_a.img level2\product
echo Unpack system_a.img
bin\imgextractor level2\system_a.img level2\system
echo Unpack vendor_a.img
bin\imgextractor level2\vendor_a.img level2\vendor

echo Deleting...
rd /s /q level2\product\app\DeskClock 2> nul
rd /s /q level2\product\app\Music 2> nul
rd /s /q level2\product\app\webview 2> nul

rd /s /q level2\system\system\app\BasicDreams 2> nul
rd /s /q level2\system\system\app\ExtShared 2> nul
rd /s /q level2\system\system\app\LiveWallpapersPicker 2> nul
rd /s /q level2\system\system\app\Traceur 2> nul
del level2\system\system\etc\default-permissions\default-permissions-google.xml 2> nul
del level2\system\system\etc\permissions\android.software.live_wallpaper.xml 2> nul
del level2\system\system\etc\permissions\com.android.vending.xml 2> nul
del level2\system\system\etc\permissions\com.google.android.gms.xml 2> nul
del level2\system\system\etc\permissions\com.google.android.gsf.login.xml 2> nul
del level2\system\system\etc\permissions\com.google.android.gsf.xml 2> nul
del level2\system\system\etc\permissions\com.google.android.katniss.xml 2> nul
del level2\system\system\etc\permissions\com.google.android.tv.remote.service.xml 2> nul
del level2\system\system\etc\permissions\privapp-permissions-google-p.xml 2> nul
del level2\system\system\etc\permissions\privapp-permissions-google-product.xml 2> nul
del level2\system\system\etc\permissions\privapp-permissions-google-system-ext.xml 2> nul
del level2\system\system\etc\permissions\split-permissions-google.xml 2> nul
del level2\system\system\etc\sysconfig\backup.xml 2> nul
del level2\system\system\etc\sysconfig\google-rollback-package-whitelist.xml 2> nul
del level2\system\system\etc\sysconfig\google-staged-installer-whitelist.xml 2> nul
rd /s /q level2\system\system\priv-app\AtvRemoteService 2> nul
rd /s /q level2\system\system\priv-app\GoogleAccountManager 2> nul
rd /s /q level2\system\system\priv-app\GoogleBackupTransport 2> nul
rd /s /q level2\system\system\priv-app\GooglePlayServices 2> nul
rd /s /q level2\system\system\priv-app\GooglePlayStore 2> nul
rd /s /q level2\system\system\priv-app\GoogleServicesFramework 2> nul
rd /s /q level2\system\system\priv-app\Katniss 2> nul
rd /s /q level2\system\system\priv-app\PackageInstaller 2> nul

rd /s /q level2\vendor\app 2> nul
del level2\vendor\etc\permissions\android.hardware.faketouch.multitouch.jazzhand.xml 2> nul
del level2\vendor\etc\permissions\android.hardware.screen.portrait.xml 2> nul
del level2\vendor\etc\permissions\android.hardware.sensor.compass.xml 2> nul
del level2\vendor\etc\permissions\android.hardware.touchscreen.multitouch.jazzhand.xml 2> nul
del level2\vendor\etc\permissions\tablet_core_hardware.xml 2> nul

echo Copy files...
xcopy /Y /E /S /H /Q "%~dp0\tmp\level1" "%~dp0\level1"
xcopy /Y /E /S /H /Q "%~dp0\tmp\level2" "%~dp0\level2"

echo Editing...

rem ro.sf.lcd_density=320
bin\sed -b -i "s/ro.sf.lcd_density=.*./ro.sf.lcd_density=320/" level2\vendor\build.prop

rem ro.setupwizard.mode=DISABLED
bin\sed -b -r "/^.*ro.setupwizard.mode.*$/d" -i level2\vendor\build.prop
bin\sed -b -r "$a ro.setupwizard.mode=DISABLED" -i level2\vendor\build.prop

rem ro.opa.eligible_device=true
bin\sed -b -r "/^.*ro.opa.eligible_device.*$/d" -i level2\vendor\build.prop
bin\sed -b -r "$a ro.opa.eligible_device=true" -i level2\vendor\build.prop

rem ro.config.wallpaper=/vendor/etc/default_wallpaper.png
bin\sed -b -r "/^.*ro.config.wallpaper.*$/d" -i level2\vendor\build.prop
bin\sed -b -r "$a ro.config.wallpaper=/vendor/etc/default_wallpaper.png" -i level2\vendor\build.prop

rem persist.sys.language=ru
bin\sed -b -r "/^.*persist.sys.language.*$/d" -i level2\vendor\build.prop
bin\sed -b -r "$a persist.sys.language=ru" -i level2\vendor\build.prop

rem persist.sys.country=RU
bin\sed -b -r "/^.*persist.sys.country.*$/d" -i level2\vendor\build.prop
bin\sed -b -r "$a persist.sys.country=RU" -i level2\vendor\build.prop

rem persist.sys.timezone=Europe/Moscow
bin\sed -b -r "/^.*persist.sys.timezone.*$/d" -i level2\vendor\build.prop
bin\sed -b -r "$a persist.sys.timezone=Europe/Moscow" -i level2\vendor\build.prop

rem Volume step (25)
bin\sed -b -i "s/ro.config.media_vol_steps=.*./ro.config.media_vol_steps=25/" level2\product\build.prop

rem Change path to file
bin\sed  -b "s|/mnt/vendor/tee/factoryreset.sh|/vendor/bin/factoryreset.sh|" -i level2\vendor\etc\init\hw\init.amlogic.rc

rem Assign file attributes
bin\sed -b -r "/^.*vendor/bin/factoryreset.sh.*$/d" -i level2\vendor_fs_config
bin\sed -b -r "$a vendor/bin/factoryreset.sh 0 2000 0755" -i level2\vendor_fs_config

rem echo. 
rem echo Please add or delete files manually and press any key to build
rem pause

echo Build odm_a.img
bin\foldersize "level2\odm"
set /a odm_size=%errorlevel%+104857600
bin\make_ext4fs -J -L odm -T -1 -S level2\odm_file_contexts -C level2\odm_fs_config -l %odm_size% -a odm level2\odm_a.img level2\odm\
call :size level2\odm_a.img
if %SIZE%==0 exit
echo Resize odm_a.img
bin\resize2fs\resize2fs -M "level2\odm_a.img"
bin\resize2fs\resize2fs -M "level2\odm_a.img"
rd /s /q level2\odm
del level2\odm_file_contexts
del level2\odm_fs_config
del level2\odm_size

echo Build product_a.img
bin\foldersize "level2\product"
set /a product_size=%errorlevel%+104857600
bin\make_ext4fs -J -L product -T -1 -S level2\product_file_contexts -C level2\product_fs_config -l %product_size% -a product level2\product_a.img level2\product\
call :size level2\product_a.img
if %SIZE%==0 exit
echo Resize product_a.img
bin\resize2fs\resize2fs -M "level2\product_a.img"
bin\resize2fs\resize2fs -M "level2\product_a.img"
rd /s /q level2\product
del level2\product_file_contexts
del level2\product_fs_config
del level2\product_size

echo Build system_b.img
rem set /p system_size=<"level2\system_size"
bin\foldersize "level2\system"
set /a system_size=%errorlevel%+104857600
bin\make_ext4fs -J -L system -T -1 -S level2\system_file_contexts -C level2\system_fs_config -l %system_size% -a system level2\system_a.img level2\system\
call :size level2\system_a.img
if %SIZE%==0 exit
echo Resize system_a.img
bin\resize2fs\resize2fs -M "level2\system_a.img"
bin\resize2fs\resize2fs -M "level2\system_a.img"
rd /s /q level2\system
del level2\system_file_contexts
del level2\system_fs_config
del level2\system_size

echo Build vendor_a.img
bin\foldersize "level2\vendor"
set /a vendor_size=%errorlevel%+104857600
bin\make_ext4fs -J -L vendor -T -1 -S level2\vendor_file_contexts -C level2\vendor_fs_config -l %vendor_size% -a vendor level2\vendor_a.img level2\vendor\
call :size level2\vendor_a.img
if %SIZE%==0 exit
echo Resize vendor_a.img
bin\resize2fs\resize2fs -M "level2\vendor_a.img"
bin\resize2fs\resize2fs -M "level2\vendor_a.img"
rd /s /q level2\vendor
del level2\vendor_file_contexts
del level2\vendor_fs_config
del level2\vendor_size

echo Unpack system_ext_a.img
bin\imgextractor level2\system_ext_a.img level2\system
rd /s /q level2\system\app 2> nul
del level2\system\etc\permissions\android.ugoos.update.service.xml 2> nul
del level2\system\etc\permissions\com.android.launcher3.xml 2> nul
del level2\system\etc\permissions\com.ugoos.ugoosfirstrun.xml 2> nul
rd /s /q level2\system\priv-app\Launcher3 2> nul
rd /s /q level2\system\priv-app\UgoosFirstRun 2> nul
rd /s /q level2\system\priv-app\Launcher3 2> nul
rd /s /q level2\system\priv-app\WallpaperCropper 2> nul
 
echo Build system_ext_a.img
bin\foldersize "level2\system"
set /a system_size=%errorlevel%+104857600
bin\make_ext4fs -J -L system -T -1 -S level2\system_file_contexts -C level2\system_fs_config -l %system_size% -a system level2\system_ext_a.img level2\system\
call :size level2\system_ext_a.img
if %SIZE%==0 exit
echo Resize system_ext_a.img
bin\resize2fs\resize2fs -M "level2\system_ext_a.img"
bin\resize2fs\resize2fs -M "level2\system_ext_a.img"
rd /s /q level2\system
del level2\system_file_contexts
del level2\system_fs_config
del level2\system_size
del level2\system_ext_size

if %drop% EQU 0 (
  if exist out rmdir /q /s out
  md out
)

set "dir=level2"
set "lpmake=%~dp0\bin\lpmake.exe"
set "busybox=%~dp0\bin\busybox.exe"
set "ro_rw=none"
set "ro_rw_string=RW"
goto main
:Usage
echo  Usage:
echo        %~n0 ^<dir^>
goto:eof
:main
set fullsize=0
echo ===================
echo Partition info
for /f %%i in ('dir /b /s "!dir!\*.img"') do (
	set size=%%~zi
	for /f %%a in ('echo !fullsize!+%%~zi ^| !busybox! bc') do set fullsize=%%a
	set partition=%%~ni
	set "command= --partition !partition!:!ro_rw!:!size!:main --image !partition!=!dir!\!partition!.img"
	echo !partition!:!size!
	set "full=!full!!command!"
	set command=
)
for /f %%i in ("!dir!\super.img.raw") do set super_size=%%~zi
echo ___________________
echo main:!fullsize!
echo super:!super_size!
echo ___________________
echo Pack in !ro_rw_string!
echo ===================
!lpmake! --metadata-size 65536 --super-name super --metadata-slots 2 --device super:!super_size! --group main:!fullsize!!full! --sparse --out level1\super.PARTITION
bin\AmlImagePack -r level1\image.cfg level1 "%out_filename%"

if exist level1 rmdir /q /s level1
if exist level2 rmdir /q /s level2

if exist tmp rmdir /q /s tmp

echo Done.

exit

:size
set SIZE=%~z1
goto :eof
