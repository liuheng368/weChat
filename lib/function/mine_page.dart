import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wechat/function/cell_spilt_widget.dart';
import 'package:wechat/function/discover/discover_cell.dart';
import 'package:wechat/tools/global.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  File _avatarFile;

  //通过mine_page来注册一个通讯渠道
  //通过注册回调:setMethodCallHandler 主动发消息:invokeMethod来完成通讯
  MethodChannel _channel = MethodChannel('mine_page');

  @override
  void initState() {
    super.initState();

    //注册该通讯渠道的回调
    _channel.setMethodCallHandler((call) {
      if (call.method == 'get_picture') {
        setState(() {
          _avatarFile = File(call.arguments.toString().substring(7));
          print(_avatarFile);
        });
        _channel.invokeMethod('vc-disminss');
      }
      return Future(() => 'flutter-setMethodCallHandler');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: Stack(
            children: <Widget>[
              Container(
                color: ThemeColor,
                child: ListView(
                  children: <Widget>[
                    //自动计算高度
                    Card(
//                    Container(
                      color: Colors.white,
//                      height: 180,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                left: 25, top: 45, bottom: 10, right: 10),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: _avatarFile != null
                                    ? FileImage(_avatarFile)
                                    : AssetImage('images/Hank.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            width: ScreenWidth(context) - 115,
                            margin: EdgeInsets.only(top: 80, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Henry', style: TextStyle(fontSize: 25)),
                                SizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '微信号:1234',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                    Image(
                                      image:
                                          AssetImage('images/icon_right.png'),
                                      width: 15,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ), //header
                    Container(height: 10, color: ThemeColor),
                    DiscoverCell.param('images/微信 支付.png', '支付'),
                    Container(height: 10, color: ThemeColor),
                    DiscoverCell.param('images/微信收藏.png', '收藏'),
                    CellSpilt.normal(),
                    DiscoverCell.param('images/微信收藏.png', '收藏'),
                  ],
                ),
              ), //Listview
              GestureDetector(
                onTap: () {
                  //通过通讯渠道主动发送方法
                  _channel
                      .invokeMethod('open_picture')
                      .then((val) => print('open_picture' + val));
                },
                child: Container(
                  height: 25,
                  margin: EdgeInsets.only(right: 15, top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[Image.asset('images/相机.png')],
                  ),
                ),
              ), //相机
            ],
          )),
    );
  }
}
