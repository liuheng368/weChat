import 'package:flutter/material.dart';
import 'package:wechat/tools/global.dart';

class CellSpilt extends StatelessWidget {
  final Color color;

  CellSpilt.normal() : this(color: ThemeColor);

  const CellSpilt({this.color}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      child: Row(
        children: <Widget>[
          Container(
            width: 15,
            color: Colors.white,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 15,
            color: color,
          )
        ],
      ),
    );
  }
}
