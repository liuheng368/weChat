import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wechat/function/discover/discover_cell.dart';
import 'package:wechat/function/discover/discover_model.dart';
import 'package:wechat/global.dart';

import '../cell_spilt_widget.dart';

class DiscoverPage extends StatelessWidget {
  final List<DiscoverModel> cellData = [
    DiscoverModel(
      imageName: 'images/朋友圈.png',
      title: '朋友圈',
    ),
    DiscoverModel(
      imageName: 'images/扫一扫2.png',
      title: '扫一扫',
    ),
    DiscoverModel(
      imageName: 'images/摇一摇.png',
      title: '摇一摇',
    ),
    DiscoverModel(
      imageName: 'images/看一看icon.png',
      title: '看一看',
    ),
    DiscoverModel(
      imageName: 'images/搜一搜 2.png',
      title: '搜一搜',
    ),
    DiscoverModel(
      imageName: 'images/附近的人icon.png',
      title: '附近的人',
    ),
    DiscoverModel(
      imageName: 'images/购物.png',
      title: '购物',
      subTitle: '618限时特价',
      subImageName: 'images/badge.png',
    ),
    DiscoverModel(
      imageName: 'images/游戏.png',
      title: '游戏',
    ),
    DiscoverModel(
      imageName: 'images/小程序.png',
      title: '小程序',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0, //底部边栏~~~
        title: Text(
          '发现',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: ThemeColor,
      ),
      body: ListView(
        children: <Widget>[
          DiscoverCell(
            model: cellData[0],
          ),
          SizedBox(
            height: 10,
          ),
          DiscoverCell(
            model: cellData[1],
          ),
          CellSpilt.normal(),
          DiscoverCell(
            model: cellData[2],
          ),
          SizedBox(
            height: 10,
          ),
          DiscoverCell(
            model: cellData[3],
          ),
          CellSpilt.normal(),
          DiscoverCell(
            model: cellData[4],
          ),
          SizedBox(
            height: 10,
          ),
          DiscoverCell(
            model: cellData[5],
          ),
          SizedBox(
            height: 10,
          ),
          DiscoverCell(
            model: cellData[6],
          ),
          CellSpilt.normal(),
          DiscoverCell(
            model: cellData[7],
          ),
          SizedBox(
            height: 10,
          ),
          DiscoverCell(
            model: cellData[8],
          ),
        ],
      ),
    );
  }
}
