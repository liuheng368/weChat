import 'package:flutter/material.dart';
import 'package:wechat/function/chat/chat_model.dart';
import 'package:wechat/function/chat/search_page.dart';
import 'package:wechat/tools/global.dart';

class SearchBarCell extends StatelessWidget {
  final List<ChatModel> data;

  const SearchBarCell({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext content) {
          return SearchPage(data: data);
        }));
      },
      child: Container(
        height: 54,
        color: ThemeColor,
        child: Stack(
          alignment: Alignment(0, 0),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/放大镜b.png',
                  width: 20,
                  color: Colors.grey,
                ),
                SizedBox(width: 5),
                Text(
                  '搜索',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final ValueChanged callBack;

  const SearchBar({Key key, this.callBack}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  //可以通过控制器来设置初始值
  TextEditingController _controller = TextEditingController(text: '初始值');

  bool _showClear = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      padding: EdgeInsets.only(right: 5, left: 5, top: 40),
      color: ThemeColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(right: 15),
              padding: EdgeInsets.only(left: 10, right: 5),
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'images/放大镜b.png',
                    width: 20,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(right: 5, bottom: 5),
                          border: InputBorder.none,
                          hintText: '搜索'),
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      autofocus: true,
                      onChanged: _textChange,
                      cursorColor: Colors.green,
                    ),
                  ),
                  (_showClear
                      ? GestureDetector(
                          onTap: () {
                            _controller.clear();
                            _textChange('');
                          },
                          child: Icon(
                            Icons.cancel,
                            size: 20,
                            color: Colors.grey,
                          ),
                        )
                      : Container())
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text(
              '取消   ',
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }

  void _textChange(text) {
    if (text.length > 0) {
      setState(() {
        _showClear = true;
      });
    } else {
      setState(() {
        _showClear = false;
      });
    }
    widget.callBack(text);
  }
}
