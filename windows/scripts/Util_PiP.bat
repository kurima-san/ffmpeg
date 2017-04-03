setlocal enabledelayedexpansion

::set current time
set time2=%time: =0%
set date2=%date: =0%
::set datetime=%date:~-10,4%%date:~-5,2%%date:~-2,2%_%time:~-11,2%%time:~-8,2%%time:~-5,2%
set datetime=%date2:~-10,4%%date2:~-5,2%%date2:~-2,2%_%time2:~-11,2%%time2:~-8,2%%time2:~-5,2%

::load setting file
for /f "tokens=1,* delims==" %%a in (setting.ini) do (
    set %%a=%%b
)

set Outputfile=%PinPOutputDir%\PinP_%datetime%.mp4

..\tools\ffmpeg^
 -i %PinPMainFile%^
 -i %PinPSubFile%^
 -filter_complex "[1]scale=%PinPScale% [pip]; [0][pip] overlay=10:main_h-overlay_h-10"^
 %Outputfile%

::right bottom
:: -filter_complex "[1]scale=%PinPScale% [pip]; [0][pip] overlay=main_w-overlay_w-10:main_h-overlay_h-10"^

::left bottom
:: -filter_complex "[1]scale=%PinPScale% [pip]; [0][pip] overlay=10:main_h-overlay_h-10"^

pause