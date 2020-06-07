import 'package:flutter/material.dart';
import 'package:wechat/root_view_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '微信Demo',
      theme: ThemeData(
        cardColor: Color.fromRGBO(1, 1, 1, 0.4),
        primaryColor: Colors.yellow, //颜色会影响状态栏、导航栏字体颜色
        highlightColor: Color.fromRGBO(0, 0, 0, 0),
        splashColor: Color.fromRGBO(0, 0, 0, 0),
      ),
      home: RootViewController(),
    );
  }
}
