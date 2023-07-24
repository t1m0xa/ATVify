@echo off

cls

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

bin\AmlImagePack -d "%in_filename%" level1

if exist level2 rmdir /q /s level2
md level2

bin\imgextractor level1\system.PARTITION level2\system
bin\imgextractor level1\vendor.PARTITION level2\vendor

del level1\*.raw.img

echo Deleting...

del level2\system\system\recovery-from-boot.p 2> nul
del level2\system\system\bin\install-recovery.sh 2> nul
del level2\system\system\bin\copy_wallpapers 2> nul
del level2\system\system\etc\init\copy_wallpapers.rc 2> nul

del level2\vendor\etc\permissions\android.hardware.faketouch.multitouch.jazzhand.xml 2> nul
del level2\vendor\etc\permissions\android.hardware.sensor.compass.xml 2> nul
del level2\vendor\etc\permissions\android.hardware.touchscreen.multitouch.jazzhand.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.faketouch.multitouch.jazzhand.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.sensor.compass.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.touchscreen.multitouch.jazzhand.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.audio.low_latency.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.faketouch.multitouch.distinct.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.faketouch.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.gamepad.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.microphone.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.screen.landscape.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.sensor.accelerometer.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.sensor.barometer.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.sensor.gyroscope.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.sensor.heartrate.ecg.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.sensor.heartrate.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.sensor.light.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.sensor.proximity.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.sensor.stepcounter.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.sensor.stepdetector.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.telephony.cdma.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.telephony.gsm.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.touchscreen.multitouch.distinct.xml 2> nul
del level2\system\system\etc\permissions\android.hardware.touchscreen.multitouch.xml 2> nul
del level2\system\system\etc\permissions\android.software.securely_removes_users.xml 2> nul
del level2\system\system\etc\permissions\android.software.verified_boot.xml 2> nul
del level2\system\system\etc\permissions\android.software.voice_recognizers.xml 2> nul
del level2\system\system\etc\permissions\com.nxp.mifare.xml 2> nul

rd /s /q level2\system\system\preinstall 2> nul

rd /s /q level2\system\system\app\Abupdate 2> nul
rd /s /q level2\system\system\app\AptoideTV 2> nul
rd /s /q level2\system\system\app\BugReportSender 2> nul
rd /s /q level2\system\system\app\FrameworkPackageStubs 2> nul
rd /s /q level2\system\system\app\WebViewGoogle 2> nul
rd /s /q level2\system\system\app\GoogleTTS 2> nul
rd /s /q level2\system\system\app\Music2Pano 2> nul
rd /s /q level2\system\system\app\PlayGamesPano 2> nul
rd /s /q level2\system\system\app\talkback 2> nul
rd /s /q level2\system\system\app\YouTubeLeanback 2> nul
rem rd /s /q level2\system\system\app\BasicDreams 2> nul
rd /s /q level2\system\system\app\Browser2 2> nul
rd /s /q level2\system\system\app\ExtShared 2> nul
rd /s /q level2\system\system\app\GoogleExtShared 2> nul
rd /s /q level2\system\system\app\GoogleCalendarSyncAdapter 2> nul
rd /s /q level2\system\system\app\GoogleContactsSyncAdapter 2> nul
rd /s /q level2\system\system\app\LiveWallpapersPicker 2> nul
rd /s /q level2\system\system\app\PhotoTable 2> nul
rd /s /q level2\system\system\app\UgoosUpdateService 2> nul
rd /s /q level2\system\system\app\Updater 2> nul
rd /s /q level2\system\system\app\webview 2> nul

rd /s /q level2\system\system\priv-app\Backdrop 2> nul
rd /s /q level2\system\system\priv-app\GoogleFeedback 2> nul
rd /s /q level2\system\system\priv-app\ManagedProvisioning 2> nul
rd /s /q level2\system\system\priv-app\CalendarProvider 2> nul
rd /s /q level2\system\system\priv-app\ExtServices 2> nul
rd /s /q level2\system\system\priv-app\GoogleBackupTransport 2> nul
rd /s /q level2\system\system\priv-app\GoogleExtServices 2> nul
rd /s /q level2\system\system\priv-app\GoogleExtShared 2> nul
rd /s /q level2\system\system\priv-app\GoogleLoginService 2> nul
rd /s /q level2\system\system\priv-app\GoogleOneTimeInitializer 2> nul
rd /s /q level2\system\system\priv-app\GooglePartnerSetup 2> nul
rd /s /q level2\system\system\priv-app\GoogleServicesFramework 2> nul
rd /s /q level2\system\system\priv-app\Katniss 2> nul
rd /s /q level2\system\system\priv-app\Launcher3 2> nul
rd /s /q level2\system\system\priv-app\Launcher3QuickStep 2> nul
rd /s /q level2\system\system\priv-app\MboxLauncher 2> nul
rd /s /q level2\system\system\priv-app\Phonesky 2> nul
rd /s /q level2\system\system\priv-app\Provision 2> nul
rd /s /q level2\system\system\priv-app\PrebuiltGmsCore 2> nul
rd /s /q level2\system\system\priv-app\PrebuiltGmsCorePano 2> nul
rd /s /q level2\system\system\priv-app\TelephonyProvider 2> nul
rd /s /q level2\system\system\priv-app\Tubesky 2> nul
rd /s /q level2\system\system\priv-app\UserDictionaryProvider 2> nul
rd /s /q level2\system\system\priv-app\Velvet 2> nul
rd /s /q level2\system\system\priv-app\WallpaperCropper 2> nul

rd /s /q level2\system\system\media\audio\ringtones 2> nul
rd /s /q level2\vendor\media\Wallpapers 2> nul

echo Editing...

bin\sed -b -i "s/ro.build.characteristics=.*./ro.build.characteristics=tv,nosdcard/" level2\system\system\build.prop

bin\sed -b -i "s/ro.sf.lcd_density=.*./ro.sf.lcd_density=320/" level2\vendor\build.prop

bin\sed -b -i "s/persist.sys.app.rotation=.*./persist.sys.app.rotation=force_land/" level2\vendor\build.prop

bin\sed -b -r "/^.*ro.setupwizard.mode.*$/d" -i level2\vendor\build.prop
bin\sed -b -r "$a ro.setupwizard.mode=DISABLED" -i level2\vendor\build.prop

bin\sed -b -r "/^.*ro.opa.eligible_device.*$/d" -i level2\vendor\build.prop
bin\sed -b -r "$a ro.opa.eligible_device=true" -i level2\vendor\build.prop

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

bin\sed -b -r "/^.*ro.config.wallpaper.*$/d" -i level2\vendor\build.prop
bin\sed -b -r "$a ro.config.wallpaper=/vendor/etc/default_wallpaper.png" -i level2\vendor\build.prop

bin\sed -b -r "/^.*factoryreset.sh.*$/d" -i level2\vendor_fs_config
bin\sed -b -r "$a vendor/bin/factoryreset.sh 0 2000 0755" -i level2\vendor_fs_config

echo Copy files...
xcopy /Y /E /S /H /Q "%~dp0\tmp\level1" "%~dp0\level1"
xcopy /Y /E /S /H /Q "%~dp0\tmp\level2" "%~dp0\level2"
xcopy /Y /E /S /H /Q "%~dp0\_preinstall" "%~dp0\level2\system\system\preinstall"

set /p system_size=<"level2\system_size"
bin\make_ext4fs -s -J -L system -T -1 -S level2\system_file_contexts -C level2\system_fs_config -l %system_size% -a system level1\system.PARTITION level2\system\
call :size level1\system.PARTITION
if %SIZE%==0 exit

set /p vendor_size=<"level2\vendor_size"
bin\make_ext4fs -s -J -L vendor -T -1 -S level2\vendor_file_contexts -C level2\vendor_fs_config -l %vendor_size% -a vendor level1\vendor.PARTITION level2\vendor\
call :size level1\vendor.PARTITION
if %SIZE%==0 exit

if %drop% EQU 0 (
  if exist out rmdir /q /s out
  md out
)

bin\AmlImagePack -r level1\image.cfg level1 "%out_filename%"

if exist level1 rmdir /q /s level1
if exist level2 rmdir /q /s level2

echo Done.

exit

:size
set SIZE=%~z1
goto :eof
