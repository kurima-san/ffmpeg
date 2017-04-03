::http://nico-lab.net/using_same_webcam_with_ffmpeg/
::カメラ・オーディオデバイスのリスト取得
::https://trac.ffmpeg.org/wiki/Capture/Webcam#vfwcap

..\tools\ffmpeg -list_devices true -f dshow -i nul 2> list_devices.txt

::pause