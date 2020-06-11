import 'dart:io';

import 'package:dio/dio.dart' as dHttp;

void main() async {
  final dio = dHttp.Dio();
  String downloadUrl =
      'http://pub.idqqimg.com/pc/misc/groupgift/fudao/CourseTeacher_1.3.16.80_DailyBuild.dmg';
  String savepath = '/Users/liuheng/Desktop/123/腾讯课堂.dmg';

  dowloadPath(dio, downloadUrl, savepath);

  dowloadCallback(dio, downloadUrl);
}

Future dowloadCallback(dHttp.Dio dio, String downloadUrl) {
  var savepath = '/Users/liuheng/Desktop/123/';
  File file = File(savepath);
  final dir_bool = file.exists(); //返回真假
  dir_bool.then((b) {
    if (b) {
      print('文件夹不存在');
      new File(savepath);
      return savepath + '腾讯课堂.dmg';
    } else {
      print('文件夹存在');
      return savepath + '腾讯课堂.dmg';
    }
  }).then((savepath) {
    dio.download(downloadUrl, (headers) {
      return savepath + '腾讯课堂.dmg';
    }, onReceiveProgress: (int count, int total) {
      print('完成' + (count / total * 100).toStringAsFixed(2) + '%');
    });
  });
}

void dowloadPath(dHttp.Dio dio, String downloadUrl, String savepath) {
  dio
      .download(downloadUrl, savepath)
      .then((val) => print(val.data.toString()))
      .whenComplete(() => print('完成了'));
}

//void dowloadPath() {}
//void dowloadCallback() {}
