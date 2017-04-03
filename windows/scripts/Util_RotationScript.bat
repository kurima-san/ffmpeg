##http://qiita.com/naga3/items/639da87ad56c67549eee

set inputfile=input.MOV
set outputfile=output.mp4

#transepose=1 -> right 90deg,
#-metadata:s:v:0 rotate=0, delete original rotation info
set routationoption=-vf transpose=1 -metadata:s:v:0 rotate=0

#same as QWinFF
set otheroptions=-crf 23.0 -vcodec libx264 -acodec aac -flags +loop -cmp chroma -partitions +parti4x4+partp8x8+partb8x8 -me_method hex -subq 6 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -b_strategy 1


#execute
..\tools\ffmpeg.exe -i %inputfile% %routationoption% %otheroptions% %outputfile%

pause