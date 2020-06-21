import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(LocationKey());

class LocationKey extends StatefulWidget {
  @override
  _LocationKeyState createState() => _LocationKeyState();
}

class _LocationKeyState extends State<LocationKey> {
  List<NormalKeyItem> _items = [
    NormalKeyItem(
      title: '111',
//      key: ValueKey(111),
//      key: ObjectKey(Object()),
      //如果使用ValueKey、ObjectKey都无法满足重复性时，则使用UniqueKey，但是每次 Widget被构建时UniqueKey都会变化
      key: UniqueKey(),
    ),
    NormalKeyItem(
      title: '222',
//      key: ValueKey(222),
      key: UniqueKey(),
    ),
    NormalKeyItem(
      title: '333',
//      key: ValueKey(333),
      key: UniqueKey(),
    ),
  ];

  String title = 'init';
  @override
  Widget build(BuildContext context) {
    print('_NormalKeyState build');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _items,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
//              title += '1';
              print(_items.removeAt(0).key.toString());
//              _items.removeAt(0);
            });
          },
        ),
      ),
    );
  }
}

class NormalKeyItem extends StatefulWidget {
  final String title;

  const NormalKeyItem({Key key, this.title}) : super(key: key);
  @override
  _NormalKeyItemState createState() => _NormalKeyItemState();
}

class _NormalKeyItemState extends State<NormalKeyItem> {
  final _color = Color.fromRGBO(
      Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0);

  @override
  Widget build(BuildContext context) {
    //在没有key的时候，setState之后build会全部重新执行
    //在有key的时候，通过hash对比之后没有发生改变的，setState之后build不会执行，可减少渲染次数
    print('build');
    return Container(
      width: 100,
      height: 100,
      color: _color,
      child: Text(widget.title),
    );
  }
}
