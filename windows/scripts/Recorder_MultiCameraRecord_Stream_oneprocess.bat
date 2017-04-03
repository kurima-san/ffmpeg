::http://nico-lab.net/using_same_webcam_with_ffmpeg/
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
  %MainID%
) else (::need space
  set MainID=%1
)

set CMD=..\tools\ffmpeg

set counter=1
:loop
%counter%

set CameraMain=CameraID%counter%
set MicMain=MicID%counter%
set OutputDirMain=OutputDir%counter%
set InVcodecMain=InVcodec%counter%
set OutVcodecMain=OutVcodec%counter%
set VideoSizeMain=VideoSize%counter%
set StreamingPortMain=StreamingPort%counter%

::get setting from setting file data
set CameraID=!%CameraMain%!
set MicID=!%MicMain%!
set OutputDir=!%OutputDirMain%!
set InVcodec=!%InVcodecMain%!
set OutVcodec=!%OutVcodecMain%!
set VideoSize=!%VideoSizeMain%!
set StreamingPort=!%StreamingPortMain%!

set Outputfile=%OutputDir%\Video%counter%_%datetime%.mp4

set /a mapID=%counter%-1
::set VideoSize="1280x720"
::set CMD=%CMD% -rtbufsize 100MB -f dshow -video_size %VideoSize% -vcodec %InVcodec% -i video=%CameraID%:audio=%MicID% -loglevel info -copyinkf -vcodec %OutVcodec% -map %mapID%:a -map %mapID%:v %Outputfile% -f mpegts udp://127.0.0.1:%StreamingPort% -vsync 1
set CMD=%CMD% -rtbufsize 100MB -f dshow -video_size %VideoSize% -vcodec %InVcodec% -i video=%CameraID%:audio=%MicID% -loglevel info -vcodec %OutVcodec% -copyinkf -map %mapID%:a -map %mapID%:v %Outputfile% -f mpegts udp://127.0.0.1:%StreamingPort% -vsync 1

set /a counter+=1
if %counter% leq %NumMultiDevice% goto loop

%CMD%

pause
