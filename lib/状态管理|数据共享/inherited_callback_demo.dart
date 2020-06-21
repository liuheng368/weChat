import 'package:flutter/material.dart';

//子类获取父类数据问题,通过callback来实现,多层嵌套时不建议使用s
void main() => runApp(InheritedDemo());

class InheritedDemo extends StatefulWidget {
  @override
  _InheritedDemoState createState() => _InheritedDemoState();
}

class _InheritedDemoState extends State<InheritedDemo> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Test1(() => count),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() => count++),
        ),
      ),
    );
  }
}

class Test1 extends StatelessWidget {
  int Function() callback;

  Test1(this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.red,
      child: Text(callback().toString()),
    );
  }
}
