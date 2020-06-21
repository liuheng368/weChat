import 'package:flutter/material.dart';
//子类获取父类数据问题

void main() => runApp(InheritedDemo());

//provider是flutter团队提供的第三方状态管理三方
class InheritedDataDemo extends InheritedWidget {
  int data;

  InheritedDataDemo({this.data, Widget child}) : super(child: child);

  //提供一个方法让子Widget访问的共享数据!
  static InheritedDataDemo of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedDataDemo>();
  }

  @override
  bool updateShouldNotify(InheritedDataDemo oldWidget) {
    return oldWidget.data != data;
  }
}

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
          child: InheritedDataDemo(
            child: Test1(),
            data: count,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
        ),
      ),
    );
  }
}

class Test1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Test2(),
    );
  }
}

class Test2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Test3(),
    );
  }
}

class Test3 extends StatefulWidget {
  @override
  _Test3State createState() => _Test3State();
}

class _Test3State extends State<Test3> {
  @override
  Widget build(BuildContext context) {
    return Text(InheritedDataDemo.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    print('状态管理导致依赖改变');
    super.didChangeDependencies();
  }
}
