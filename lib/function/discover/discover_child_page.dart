import 'package:flutter/material.dart';
import 'package:wechat/tools/global.dart';

class DiscoverChildPage extends StatelessWidget {
  final String title;

  const DiscoverChildPage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: ThemeColor,
      ),
      body: Container(),
    );
  }
}
