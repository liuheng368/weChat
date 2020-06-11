import 'dart:io';

import 'package:dio/dio.dart' as dHttp;

typedef ProgressCallback = void Function(int count, int total);

class httpManage<T> {
  static final dHttp.Dio dio = dHttp.Dio();

  static Future<dynamic> request(String url,
      {String method = 'get',
      Map<String, String> headers,
      Map<String, dynamic> queryParameters,
      int timeOut,
      ProgressCallback callback}) {
    //Content-Type:application/json
    switch (method) {
      case 'get':
        return _get(url,
            headers: headers,
            queryParameters: queryParameters,
            timeOut: timeOut);
        break;
      case 'post':
        return _post(url,
            headers: headers,
            queryParameters: queryParameters,
            timeOut: timeOut);
        break;
      default:
        print('未知类型');
        break;
    }
  }

  static Future<dynamic> download(
      String url, String savePath, String fileName, String downloadUrl,
      {Map<String, String> headers,
      Map<String, dynamic> queryParameters,
      int timeOut,
      ProgressCallback progresscallback}) {
    final options = dHttp.Options(receiveTimeout: timeOut, headers: headers);
    File file = File(savePath);
    final dir_bool = file.exists(); //返回真假
    return dir_bool
        .then((b) {
          if (b) {
            print('文件夹不存在');
            new File(savePath);
            return savePath + fileName;
          } else {
            print('文件夹存在');
            return savePath + fileName;
          }
        })
        .then((savePath) => dio.download(downloadUrl, headers,
            onReceiveProgress: progresscallback,
            queryParameters: queryParameters,
            options: options))
        .then((response) => response);
  }

  static Future<dynamic> _get(String url,
      {Map<String, String> headers,
      Map<String, dynamic> queryParameters,
      int timeOut}) {
    final options =
        dHttp.Options(method: 'get', receiveTimeout: timeOut, headers: headers);
    return dio
        .request(url, queryParameters: queryParameters, options: options)
        .then((response) {
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data);
      }
    });
  }

  static Future<dynamic> _post(String url,
      {Map<String, String> headers,
      Map<String, dynamic> queryParameters,
      int timeOut}) {
    final options = dHttp.Options(
        method: 'post', receiveTimeout: timeOut, headers: headers);
    return dio
        .request(url, queryParameters: queryParameters, options: options)
        .then((response) {
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data);
      }
    });
  }
}

class Response<T> {
  final T data;
  final dHttp.Headers headers;
  final dHttp.RequestOptions request;
  final int statusCode;

  Response({this.data, this.headers, this.request, this.statusCode});
}
