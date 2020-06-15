import 'package:flutter/material.dart';
import 'package:wechat/function/chat/search_bar.dart';
import 'package:wechat/function/chat/search_cell.dart';

import 'chat_model.dart';

class SearchPage extends StatefulWidget {
  final List<ChatModel> data;

  const SearchPage({Key key, this.data}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ChatModel> _selectData = [];

  String _searchText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        //关闭键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        children: <Widget>[
          SearchBar(callBack: (str) {
            _selectData.clear();
            if (str.length > 0) {
              for (int i = 0; i < widget.data.length - 1; i++) {
                if (widget.data[i].name.contains(str)) {
                  _selectData.add(widget.data[i]);
                }
              }
            }
            setState(() {
              _searchText = str;
            });
          }),
          Expanded(
            flex: 1,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return SearchCell(
                    cellData: _selectData[index],
                    searchText: _searchText,
                  );
                },
                itemCount: _selectData.length,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
