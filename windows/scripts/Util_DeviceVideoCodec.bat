##http://nico-lab.net/using_same_webcam_with_ffmpeg/
rem ����ꂽ�J�����̑Ή��R�[�f�b�N�𒲂ׂ�
set Camera="HD Pro Webcam C920"

..\tools\ffmpeg -list_options true -f dshow -i video=%Camera%  2> list_vcodec.txt

::pause