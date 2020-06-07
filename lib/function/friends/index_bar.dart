import 'package:flutter/material.dart';

import '../../global.dart';
import 'friends_data.dart';

class IndexBar extends StatefulWidget {
  final void Function(String) indexBarCallBack;

  const IndexBar({Key key, this.indexBarCallBack}) : super(key: key);

  @override
  _IndexBarState createState() => _IndexBarState();
}

class _IndexBarState extends State<IndexBar> {
  bool _bSelect = false;
  String _currentStr = 'A';
  double _indicatorY = 0.0;

  int getIndex(BuildContext context, Offset detail) {
    RenderBox box = context.findRenderObject();
    double osY = box.globalToLocal(detail).dy;
    double itemHeight = ScreenHeight(context) / 2 / INDEX_WORDS.length;
    return osY ~/ itemHeight.clamp(0, INDEX_WORDS.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: 130,
      height: ScreenHeight(context) / 2,
      right: 0.0,
      top: ScreenHeight(context) / 8,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment(0, _indicatorY),
            width: 100,
            child: !_bSelect
                ? null
                : Stack(
                    alignment: Alignment(-0.2, 0),
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/气泡.png'),
                        width: 60,
                      ),
                      Text(
                        _currentStr,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ), //气泡
          ),
          GestureDetector(
            onVerticalDragUpdate: (DragUpdateDetails details) {
              int index = getIndex(context, details.globalPosition);
              widget.indexBarCallBack(INDEX_WORDS[index]);
              setState(() {
                _indicatorY = 2.2 / 28 * index - 1.1;
                _bSelect = true;
                _currentStr = INDEX_WORDS[index];
              });
            },
            onVerticalDragDown: (DragDownDetails details) {
              int index = getIndex(context, details.globalPosition);
              widget.indexBarCallBack(INDEX_WORDS[index]);
              setState(() {
                _indicatorY = 2.2 / 28 * index - 1.1;
                _bSelect = true;
                _currentStr = INDEX_WORDS[index];
              });
            },
            onVerticalDragEnd: (DragEndDetails details) {
              setState(() {
                _bSelect = false;
              });
            },
            child: Container(
              width: 30,
              color: _bSelect ? Color.fromRGBO(1, 1, 1, 0.4) : Colors.white,
              child: Column(
                children: INDEX_WORDS
                    .map<Widget>((str) => Expanded(
                        child: Text(str,
                            style: TextStyle(
                                fontSize: 12,
                                color:
                                    _bSelect ? Colors.white : Colors.black))))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
