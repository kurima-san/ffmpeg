##http://nico-lab.net/using_same_webcam_with_ffmpeg/
rem ビデオと音声をキャプチャ
::引数でデバイスIDを指定できる

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

::set main id from argument
if "%1"=="" (
  %MainID%
) else (::need space
  set MainID=%1
)
::check
::!%MainID%!
::pause

set CameraMain=CameraID%MainID%
set MicMain=MicID%MainID%
set OutputDirMain=OutputDir%MainID%
set InVcodecMain=InVcodec%MainID%
set OutVcodecMain=InVcodec%MainID%
set VideoSizeMain=VideoSize%MainID%
set StreamingPortMain=StreamingPort%MainID%

::get setting from setting file data
set CameraID=!%CameraMain%!
set MicID=!%MicMain%!
set OutputDir=!%OutputDirMain%!
set InVcodec=!%InVcodecMain%!
set OutVcodec=!%OutVcodecMain%!
set VideoSize=!%VideoSizeMain%!
set StreamingPort=!%StreamingPortMain%!

set Outputfile=%OutputDir%"\Video%MainID%_%datetime%.mp4"

::set VideoSize="1280x720"


..\tools\ffplay^
 -rtbufsize 100MB -f dshow^
 -video_size %VideoSize% -i video=%CameraID%:audio=%MicID%

::..\tools\ffplay -rtbufsize 100MB -f dshow -vcodec %InputVideoCodec% -video_size %VideoSize% -i video=%CameraID%:audio=%MicID% -loglevel info -video_device_save %Outputfile%

pause