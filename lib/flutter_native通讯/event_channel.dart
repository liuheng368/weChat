import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(EventcMessageChannelDemo());

class EventcMessageChannelDemo extends StatefulWidget {
  @override
  _EventcMessageChannelDemoState createState() =>
      _EventcMessageChannelDemoState();
}

class _EventcMessageChannelDemoState extends State<EventcMessageChannelDemo> {
  //通过EventChannel来注册原生主动通讯的渠道，不同于methodChannel/basicChannel的双向通讯而言
  //通过注册回调:receiveBroadcastStream().listen来进行数据的监听
  //原生功能在iOS项目

  EventChannel _channel = EventChannel('flutter_event_channel');
  MethodChannel _methodChannel = MethodChannel('flutter_method_channel');
  String _stateStr = "未知";

  @override
  void initState() {
    super.initState();
    _channel.receiveBroadcastStream().listen((val) {
      setState(() {
        _stateStr = val;
      });
    }, onError: _onError);
  }

  void _onError(Object error) {
    print(error);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('BasicChannel'),
        ),
        body: Container(
          child: Text('当前系统版本号:' + _stateStr),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            print('获取系统版本号');
            _methodChannel.invokeMethod('get_battery');
          },
        ),
      ),
    );
  }
}
