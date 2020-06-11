import 'package:flutter/material.dart';
import 'package:wechat/function/cell_spilt_widget.dart';
import 'package:wechat/function/discover/discover_child_page.dart';
import 'package:wechat/gestTap_cell.dart';

import '../../tools/global.dart';

class FriendCell extends StatelessWidget {
  final String imageUrl;
  final String imageAssets;
  final String title;
  final String groupTitle;

  FriendCell({this.imageUrl, this.imageAssets, this.title, this.groupTitle});

  @override
  Widget build(BuildContext context) {
    return GestTapCell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                DiscoverChildPage(title: title)));
      },
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment(-1, 0),
            width: ScreenWidth(context),
            height: groupTitle != null ? 30 : 0,
            padding: EdgeInsets.only(left: 20),
            color: Colors.grey,
            child: groupTitle != null
                ? Text(
                    groupTitle,
                    style: TextStyle(fontSize: 20),
                  )
                : null,
          ), //头
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageAssets != null
                            ? AssetImage(imageAssets)
                            : NetworkImage(imageUrl)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ), //照片
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 17),
                  ),
                ), //名字
              ],
            ),
          ), //内容
          CellSpilt.normal(), //分割线
        ],
      ),
    );
  }
}
