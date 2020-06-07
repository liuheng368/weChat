import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wechat/global.dart';

import '../../gestTap_cell.dart';
import 'chat_cell.dart';
import 'chat_model.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class Chat {}

class _ChatPageState extends State<ChatPage> {
  /**
   * 生成导航栏Item
   * */
  PopupMenuItem popItem(String imgName, String title) {
    return PopupMenuItem(
      value: title,
      height: 44,
      child: Row(children: <Widget>[
        Image.asset(
          imgName,
          width: 20,
          height: 20,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white),
        )
      ]),
    );
  }

  List<ChatModel> _dataSource = [];
  @override
  void initState() {
    super.initState();
    getDataList()
        .then((data) {
          setState(() {
            _dataSource = data;
          });
        })
        .whenComplete(() => print('finish'))
        .catchError((e) => {print('错误：${e}')})
//        .timeout(Duration(seconds: 5))
        .catchError((e) => {print('超时${e}')});
  }

  /*获取数据*/
  Future<List<ChatModel>> getDataList() async {
    final res = await http
        .get('http://rap2.taobao.org:38080/app/mock/257078/api/chat/list');
    if (res.statusCode == 200) {
      final List<ChatModel> result = json
          .decode(res.body)['chatList']
          .map<ChatModel>((item) => ChatModel.decode(item))
          .toList();
      print('正在加载${result.length}');
      return result;
    } else {
      Exception(
          'statusCode:${res.statusCode} \n content:${json.decode(res.body)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (title) {
                print(title);
              },
              offset: Offset(0, 50),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Image.asset(
                  'images/圆加.png',
                  width: 25,
                  height: 25,
                ),
              ),
              itemBuilder: (BuildContext context) {
                return [
                  popItem('images/发起群聊.png', '发起群聊'),
                  popItem('images/添加朋友.png', '添加朋友'),
                  popItem('images/扫一扫1.png', '扫一扫'),
                  popItem('images/收付款.png', '收付款'),
                ];
              }) //导航栏按钮
        ],
        title: Text('聊天'),
        backgroundColor: ThemeColor,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext contene, int index) {
          return GestTapCell(child: ChatCell(cellData: _dataSource[index]));
        },
        itemCount: _dataSource.length,
      ),
//      body: Container(
//        child: FutureBuilder(
//          future: getDataList(),
//          builder:
//              (BuildContext context, AsyncSnapshot<List<ChatModel>> snapshot) {
//            if (snapshot.connectionState == ConnectionState.waiting) {
//              return Center(child: Text('正在加载'));
//            } else {
//              return ListView(
//                  children: snapshot.data
//                      .map<Widget>((item) =>
//                          GestTapCell(child: ChatCell(cellData: item)))
//                      .toList());
//            }
//          },
//        ),
//      ),
    );
  }
}
