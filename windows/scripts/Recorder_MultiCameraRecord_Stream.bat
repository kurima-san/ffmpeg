::http://nico-lab.net/using_same_webcam_with_ffmpeg/
rem �r�f�I�Ɖ������L���v�`��, �J�����ƃ}�C�N��ID�̓f�o�C�X����Alternative name�̗����Ŏg����C�����������f�o�C�X����ʂ���ꍇ�́CAlternative name���g������

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

set counter=1
:loop
start .\Recorder_CameraRecord_Stream.bat %counter%
set /a counter+=1
if %counter% leq %NumMultiDevice% goto loop

::pause
