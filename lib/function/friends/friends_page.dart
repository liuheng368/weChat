import 'package:flutter/material.dart';
import 'package:wechat/function/discover/discover_child_page.dart';
import 'package:wechat/function/friends/friend_cell.dart';
import 'package:wechat/function/friends/friends_data.dart';
import 'package:wechat/function/friends/index_bar.dart';
import 'package:wechat/global.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final List<FriendsModel> _listDatas = [];
  final _scrollerController = ScrollController();

  final Map _groupOffsetMap = {
    INDEX_WORDS[0]: 0.0,
    INDEX_WORDS[1]: 0.0,
  };

  @override
  void initState() {
    super.initState();

    _listDatas..addAll(datas)..addAll(datas);
    _listDatas.sort((FriendsModel first, FriendsModel last) {
      return first.indexLetter.compareTo(last.indexLetter);
    });

    //_groupOffsetMap
    //_offSet
    double _offSet = 64.5 * 4;
    for (int i = 0; i < _listDatas.length; i++) {
      if (i == 0) {
        _groupOffsetMap.addAll({_listDatas[0].indexLetter: _offSet});
        _offSet += 30 + 64.5;
      } else if (_listDatas[i].indexLetter != _listDatas[i - 1].indexLetter) {
        _groupOffsetMap.addAll({_listDatas[i].indexLetter: _offSet});
        _offSet += 30 + 64.5;
      } else {
        _offSet += 64.5;
      }
    }
    print(_groupOffsetMap);
  }

  Widget itemBuilder(BuildContext context, int index) {
    if (index < 4) {
      return FriendCell(
          title: headerData[index].name,
          imageAssets: headerData[index].imageUrl);
    }
    bool bGroupTitle = index > 4 &&
        _listDatas[index - 4].indexLetter == _listDatas[index - 5].indexLetter;
    return FriendCell(
        title: _listDatas[index - 4].name,
        imageUrl: _listDatas[index - 4].imageUrl,
        groupTitle: bGroupTitle ? null : _listDatas[index - 4].indexLetter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor,
      appBar: AppBar(
        title: Text('通讯录'),
        backgroundColor: ThemeColor,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15),
            child: GestureDetector(
              child: Image.asset(
                'images/icon_friends_add.png',
                width: 25,
                height: 25,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return DiscoverChildPage(title: '添加好友');
                  }),
                );
              },
            ),
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: ListView.builder(
                  itemBuilder: itemBuilder,
                  itemCount: _listDatas.length + headerData.length,
                  controller: _scrollerController),
            ), //listview
            IndexBar(
              indexBarCallBack: (currentStr) {
                if (_groupOffsetMap[currentStr] != null) {
                  _scrollerController.animateTo(_groupOffsetMap[currentStr],
                      duration: Duration(seconds: 1), curve: Curves.easeIn);
                }
              },
            ), //silder
          ],
        ),
      ),
    );
  }
}
