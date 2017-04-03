::http://www.oodlestechnologies.com/blogs/PICTURE-IN-PICTURE-effect-using-FFMPEG
::overlaying camera2 on bottom right with sound of camera1 video
rem ビデオと音声をキャプチャ, カメラとマイクのIDはデバイス名かAlternative nameの両方で使える，ただし同じデバイスを区別する場合は，Alternative nameを使うこと

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
  %PinPMain%
) else (::need space
  set PinPMain=%1
)
if "%2"=="" (
  %PinPSub%
) else (::need space
  set PinPSub=%2
)

::MainCamera
set CameraMain=CameraID%PinPMain%
set MicMain=MicID%PinPMain%
set InVcodecMain=InVcodec%PinPMain%
set VideoSizeMain=VideoSize%PinPMain%
::get setting from setting file data
set MainCameraID=!%CameraMain%!
set MainMicID=!%MicMain%!
set MainInVcodec=!%InVcodecMain%!
set MainVideoSize=!%VideoSizeMain%!

::SubCamera
set CameraSub=CameraID%PinPSub%
set MicSub=MicID%PinPSub%
set InVcodecSub=InVcodec%PinPSub%
set VideoSizeSub=VideoSize%PinPSub%
::get setting from setting file data
set SubCameraID=!%CameraSub%!
set SubMicID=!%MicSub%!
set SubInVcodec=!%InVcodecSub%!
set SubVideoSize=!%VideoSizeSub%!

set Outputfile=%PinPOutputDir%\PinP_%datetime%.mp4

..\tools\ffmpeg^
 -rtbufsize 214MB^
 -f dshow^
 -vsync 1^
 -video_size %MainVideoSize% -vcodec %MainInVcodec% -i video=%MainCameraID%:audio=%MainMicID%^
 -rtbufsize 214MB^
 -f dshow^
 -vsync 1^
 -video_size %SubVideoSize% -vcodec %SubInVcodec% -i video=%SubCameraID%:audio=%SubMicID%^
 -filter_complex "[1]scale=%PinPScale% [pip]; [0][pip] overlay=main_w-overlay_w-10:main_h-overlay_h-10"^
 -profile:v main -level 3.1 -b:v 440k -ar 44100 -ab 128k -video_size %MainVideoSize% -vcodec %PinPOutVcodec% -acodec aac^
 %Outputfile% -vsync 1^
  -f mpegts udp://127.0.0.1:%PinPStreamingPort%

::..\tools\ffmpeg -rtbufsize 100MB -f dshow -video_size %VideoSize% -i video=%CameraID1%:audio=%MicID1% -i video=%CameraID2%:audio=%MicID2% -loglevel info -copyinkf  -vcodec %VideoCodec% %Outputfile1% -vcodec %VideoCodec% %Outputfile2%

pause