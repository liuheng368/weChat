import 'package:flutter/material.dart';

import 'chat_model.dart';

class SearchCell extends StatelessWidget {
  final ChatModel cellData;
  final String searchText;

  SearchCell({Key key, this.cellData, this.searchText}) : super(key: key);

  TextStyle _normalStyle = TextStyle(
    fontSize: 15,
    color: Colors.black,
  );
  TextStyle _highlightStyle = TextStyle(
    fontSize: 15,
    color: Colors.green,
  );
  Widget _getRichName() {
    List<String> _strList = cellData.name.split(searchText);
    List<TextSpan> _list = [];
    for (int i = 0; i < _strList.length - 1; i++) {
      _list.add(TextSpan(text: _strList[i], style: _normalStyle));
      if (i != _strList.length - 1) {
        _list.add(TextSpan(text: searchText, style: _highlightStyle));
      }
    }
    return RichText(text: TextSpan(children: _list));
  }

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
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getRichName(),
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
            ),
          )
        ],
      ),
    );
  }
}
