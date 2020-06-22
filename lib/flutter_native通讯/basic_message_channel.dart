import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(BasicMessageChannelDemo());

class BasicMessageChannelDemo extends StatefulWidget {
  @override
  _BasicMessageChannelDemoState createState() =>
      _BasicMessageChannelDemoState();
}

class _BasicMessageChannelDemoState extends State<BasicMessageChannelDemo> {
  //通过flutter_basic_channel来注册一个多次通讯渠道，不同于methodChannel的单次而言
  //通过注册回调:setMessageHandler 主动发消息:send来完成通讯
  //原生功能在iOS项目

  BasicMessageChannel _channel =
      BasicMessageChannel('flutter_basic_channel', StandardMessageCodec());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('BasicChannel'),
        ),
        body: Container(
          child: TextField(
            onChanged: (val) {
              _channel
                  .send('flutter--->' + val)
                  .then((val) => print(val + 'fluuter'));
            },
          ),
        ),
      ),
    );
  }
}
