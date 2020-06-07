import 'package:flutter/material.dart';

class GestTapCell extends StatefulWidget {
  final Widget child;
  final void Function() onTap;

  const GestTapCell({Key key, this.onTap, this.child}) : super(key: key);

  @override
  _GestTapCellState createState() => _GestTapCellState();
}

class _GestTapCellState extends State<GestTapCell> {
  bool bSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
        child: widget.child,
      ),
    );
  }
}
