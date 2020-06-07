import 'package:flutter/material.dart';
import 'package:wechat/function/%20chat/chat_model.dart';

import '../../global.dart';

class ChatCell extends StatelessWidget {
  final ChatModel cellData;

  const ChatCell({Key key, this.cellData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              image: DecorationImage(
                image: NetworkImage(cellData.imageUrl),
              ),
            ),
          ), //头像
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            width: ScreenWidth(context) - 104,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  cellData.name,
                  style: TextStyle(fontSize: 24),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    cellData.message,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
