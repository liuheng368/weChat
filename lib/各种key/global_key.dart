import 'package:flutter/material.dart';

//父类更新子类问题
void main() => runApp(GlobalKeyDemo());
//void main() => runApp(GlobalCallbackDemo());

//父类获取子类的state状态时使用GlobalKey
class GlobalKeyDemo extends StatelessWidget {
  final GlobalKey<_GlobalKeyItemState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: GlobalKeyItem(key: _globalKey),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _globalKey.currentState.setState(() {
                _globalKey.currentState.count++;
              });
            },
          )),
    );
  }
}

class GlobalKeyItem extends StatefulWidget {
  GlobalKeyItem({Key key}) : super(key: key);

  @override
  _GlobalKeyItemState createState() => _GlobalKeyItemState();
}

class _GlobalKeyItemState extends State<GlobalKeyItem> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    print(count);
    return Center(
      child: Text(count.toString()),
    );
  }
}

//另一种回调方式解决此问题,父类更新子类问题
class GlobalCallbackDemo extends StatelessWidget {
  _GlobalCallbackItemState _state = _GlobalCallbackItemState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GlobalCallbackItem(callback: (callback) {
          _state = callback;
        }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _state.setState(() {
                _state.count++;
              });
            }),
      ),
    );
  }
}

class GlobalCallbackItem extends StatefulWidget {
  Function(_GlobalCallbackItemState) callback;

  GlobalCallbackItem({Key key, this.callback}) : super(key: key);

  @override
  _GlobalCallbackItemState createState() => _GlobalCallbackItemState();
}

class _GlobalCallbackItemState extends State<GlobalCallbackItem> {
  int count = 0;

  @override
  void initState() {
    super.initState();
    widget.callback(this);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(count.toString()),
    );
  }
}
