import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';

void main() {
  print('开始');
  computeTest();
}

/*
* computeTest是Isolate的高层封装
* */
void computeTest() {
  //创建Port
  ReceivePort port = ReceivePort();
  compute(comFunc, '初始值').then((val) => print(val));
}

String comFunc(str) {
  return '${str}处理';
}

/*
* Isolate 多线程
*   ReceivePort如果使用到变量，变量是进行深拷贝的值拷贝.内部修改值并不会影响外部变量本身
* */
Future<void> IsolateTest() async {
  //创建Port
  ReceivePort port = ReceivePort();
//创建isolate
  Isolate iso = await Isolate.spawn(isoFunc, port.sendPort);

  port.listen((val) {
    print('内部a=$a');
    a = val;
    port.close();
    iso.kill();
  });

  sleep(Duration(seconds: 1));
  print('外部a=$a');
}

int a = 1;

void isoFunc(SendPort port) {
  sleep(Duration(seconds: 1));
  a = 200;
  print(port);
  port.send(100);
}

//开始 , 5, 3,6,8,7,1,4,10,2,9
void testFuture4() {
  Future x1 = Future(() => null);
  x1.then((value) {
    print('6');
    scheduleMicrotask(() => print('7'));
  }).then((value) => print('8'));
  Future x = Future(() => print('1'));
  x.then((value) {
    print('4');
    Future(() => print('9'));
  }).then((value) => print('10'));

  Future(() => print('2'));
  scheduleMicrotask(() => print('3'));

  print('5');
}

/*
*  scheduleMicrotask微任务
*  在同一方法体中微任务优先级高于Future，
* */
void MicrotTest() {
  print('进入');
  Future(() {
    print('A');
    scheduleMicrotask(() {
      print('A ---- scheduleMicroTask');
    });
    return Future(() => print('A--Future'));
  }).then((value) => print('A结束'));
  scheduleMicrotask(() {
    print('scheduleMicroTask');
  });
}

/*
*  Future异步组
* 在组中是按照同步执行
* */
void FutureGroup() {
  print('进入');
  Future.wait([
    Future.sync(() {
      sleep(Duration(seconds: 2));
      print('结束1');
      return '任务一';
    }),
    Future.sync(() {
      sleep(Duration(seconds: 1));
      print('结束2');
      return '任务二';
    }),
  ]).then((value) {
    print(value);
  });
  print('结束');
}

/*
*  Future也可以同步执行
* */
void FutureSync() {
  print('进入');
  Future.sync(() {
    sleep(Duration(seconds: 1));
    print('异步操作');
  });
  print('结束');
}

//future的优先级比then低
/*
*  Future执行完之后， 会将涉及到的所有then进行一次性添加
* */
void FutureThenOrder() {
  Future(() {
    sleep(Duration(seconds: 1));
    return '第一个异步处理';
  }).then((e) {
    print(e);
    return Future(() {
      sleep(Duration(seconds: 1));
      return '第二个异步处理';
    });
  }).then((e) {
    print(e);
    return '第一个异步处理2';
  });
}

/*
* 1，FutureOr<T>表示可以返回一个Future对象或者是<T>实例
* 2，catchError在then前时，无法阻止then的执行,因为当前then实际上是在捕获catcherror这个Future
* 3, catchError的闭包返回值是依附上一层的<T>,如果上一层没有返回值，catcherror中的返回值需要单声明变量后使用
* */
Future<void> throwError() async {
  print('进入');

  Future future = Future(() {
    //1
    print('异步操作');
    sleep(Duration(seconds: 1));
//    return '异步完成';
    throw Exception('出错了');
  }).then((val) {
    print('第一次then:${val}');
    return '第一次then结束';
  }).catchError((e) {
    print('errpr:${e}');
    return '错误处理'; //3
  }).then((e) => print(e)); //2
  print('结束');
}

/*
*   1,使用await以后下方所有代码都将进行同步执行
*   2,async/await必须成对出现，使用async进行方法的修饰后返回值必须也是Future<T>
* */
Future<void> getParams1() async {
  print('进入');

  await Future(() {
    sleep(Duration(seconds: 1));
    print('异步操作');
  });

  print('结束');
}
