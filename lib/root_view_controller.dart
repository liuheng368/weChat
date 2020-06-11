import 'package:flutter/material.dart';
import 'package:wechat/function/chat/chat_page.dart';
import 'package:wechat/function/discover/discover_page.dart';
import 'package:wechat/function/friends/friends_page.dart';
import 'package:wechat/function/mine_page.dart';

class RootViewController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootViewController> {
  int currentIndex = 0;
  final List _pageList = [
    ChatPage(),
    FriendsPage(),
    DiscoverPage(),
    MinePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.green,
//        selectedItemColor: Colors.black,
        selectedFontSize: 12.0,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/tabbar_chat.png',
              width: 20,
              height: 20,
            ),
            activeIcon: Image.asset(
              'images/tabbar_chat_hl.png',
              width: 20,
              height: 20,
            ),
            title: Text('微信'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/tabbar_friends.png',
              width: 20,
              height: 20,
            ),
            activeIcon: Image.asset(
              'images/tabbar_friends_hl.png',
              width: 20,
              height: 20,
            ),
            title: Text('通讯录'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/tabbar_discover.png',
              width: 20,
              height: 20,
            ),
            activeIcon: Image.asset(
              'images/tabbar_discover_hl.png',
              width: 20,
              height: 20,
            ),
            title: Text('发现'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/tabbar_mine.png',
              width: 20,
              height: 20,
            ),
            activeIcon: Image.asset(
              'images/tabbar_mine_hl.png',
              width: 20,
              height: 20,
            ),
            title: Text('我的'),
          ),
        ],
      ),
    );
  }
}
