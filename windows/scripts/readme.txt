・WindowsでC920のハードウェアエンコードをffmpegから使用するにはLogicoolのドライバーをアンインストールしてwindowsの標準ドライバーを使うこと

・setting.ini
各種一括設定
複数のデバイスを使用しない場合はID=1のものを使用する

・録画
Recorder_CameraRecord.bat
setting.iniのMainIDデバイスの録画を行う
ただし，引数でデバイスIDを指定できる

Recorder_CameraRecord_Stream.bat
setting.iniのMainIDデバイスの録画・ストリーミングを行う
ただし，引数でデバイスIDを指定できる

Recorder_MultiCameraRecord_Stream.bat
setting.iniのNumMultiDeviceの個数分ID=1から順にRecorder_CameraRecord_Stream.batを実行する
異なるプロセスで録画する

Recorder_MultiCameraRecord_Stream_oneprocess.bat
1つのプロセスからffmpegを並列で走らせ，複数カメラを同時に録画する
こちらのほうが同期しない！！！

・再生
Player_CameraPlayer.bat
setting.iniのMainIDデバイスの再生を行う
ただし，引数でデバイスIDを指定できる

Player_StreamingPlayer.bat
setting.iniのMainIDデバイスのストリーミングの再生を行う
ただし，引数でデバイスIDを指定できる


・その他
Util_DeviceListup.bat
list_devices.txtに使用できるカメラ・オーディオデバイス名とAlternative nameを出力する

Util_DeviceVideoCodec.bat
list_vcodec.txtに使用できる指定のカメラデバイスの出力コーデックを出力する

Util_RotationScript.bat
動画に回転情報を加え，縦長の動画にエンコードするスクリプト

Util_PiP.bat
2つの動画からpicture in picture動画を作る

Util_PbP.bat
2つの動画からpicture by picture動画を作る
picture in pictureのスクリプトで重ねる動画をちっさくするのではなく，クロッピングするようにしただけ


##############################
https://ubuntuforums.org/showthread.php?t=2143155
http://qiita.com/scleen_x_x/items/7f857f2d08de22dee274
なぜ同じプロセスでカメラを同時にキャプチャするとシンクロしないのか？

しかし，別プロセスで複数カメラをキャプチャするとだいたいシンクロするのに，別プロセスでffplayすると別カメラで遅延の量がちがうのはなぜ？
