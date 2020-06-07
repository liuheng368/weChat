import 'package:flutter/material.dart';
import 'package:wechat/global.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

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
      body: Container(),
    );
  }
}
