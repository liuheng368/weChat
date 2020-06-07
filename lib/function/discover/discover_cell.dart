import 'package:flutter/material.dart';
import 'package:wechat/function/discover/discover_model.dart';

import 'discover_child_page.dart';

// ignore: must_be_immutable
class DiscoverCell extends StatefulWidget {
  DiscoverModel model;

  DiscoverCell({this.model});

  DiscoverCell.param(String imageName, String title) {
    DiscoverModel m = DiscoverModel(imageName: imageName, title: title);
    this.model = m;
  }

  @override
  _DiscoverCellState createState() => _DiscoverCellState();
}

class _DiscoverCellState extends State<DiscoverCell> {
  bool bSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                DiscoverChildPage(title: widget.model.title)));
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          bSelected = true;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          bSelected = false;
        });
      },
      onTapCancel: () {
        setState(() {
          bSelected = false;
        });
      },
      child: Container(
        color: bSelected ? Colors.grey : Colors.white,
        height: 54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    widget.model.imageName,
                    width: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(widget.model.title)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  widget.model.subTitle != null
                      ? Text(widget.model.subTitle)
                      : Text(''),
                  SizedBox(width: 5),
                  widget.model.subImageName != null
                      ? Image.asset(
                          widget.model.subImageName,
                          width: 20,
                        )
                      : Container(),
                  Image.asset(
                    'images/icon_right.png',
                    width: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
