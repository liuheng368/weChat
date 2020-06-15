import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wechat/function/chat/search_bar.dart';
import 'package:wechat/tools/global.dart';
import 'package:wechat/tools/http_manage.dart';

import '../../gestTap_cell.dart';
import 'chat_cell.dart';
import 'chat_model.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

/*
*   abstract类：类似于协议
* 使用：
* 1，继承：使用关键字extends，可重写父类方法、属性
* 2，接口：使用关键字implements,必须重写（实现）父类方法、属性
*
*   Mixins类：
* 1，类似于扩展，可实现多继承，也可重写
* 2，使用with来引用，Mixins类只能继承自 Object
* */
class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin {
  //定时器
  Timer _timer;

  List<ChatModel> _dataSource = [];
  @override
  void initState() {
    super.initState();
    print('来了');

    int _count = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _count++;
      print(_count);
      if (_count > 9) {
        _timer.cancel();
      }
    });

    /*获取数据*/
    httpManage
        .request('http://rap2.taobao.org:38080/app/mock/257078/api/chat/list',
            timeOut: 1000)
        .then((data) {
          print(data);
          final List<ChatModel> result = data['chatList']
              .map<ChatModel>((item) => ChatModel.decode(item))
              .toList();
          setState(() {
            _dataSource = result;
          });
        })
        .catchError((e) => {print('错误：${e}')})
        .whenComplete(() => print('finish'));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: ThemeColor,
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
        elevation: 0, //取消navBar下面的阴影
      ),
      body: ListView.builder(
        itemCount: _dataSource.length + 1,
        itemBuilder: cellBuilder,
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

  Widget cellBuilder(BuildContext contene, int index) {
    if (index == 0) {
      return SearchBarCell(
        data: _dataSource,
      );
    }

    //index==0是是搜索栏
    index--;
    return GestTapCell(child: ChatCell(cellData: _dataSource[index]));
  }

  @override
  bool get wantKeepAlive => true;

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
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
