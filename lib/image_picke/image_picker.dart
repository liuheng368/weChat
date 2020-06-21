import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//使用三方插件image_picker进行图片选择，只需要在flutter内实现即可。

void main() => runApp(ImagePickerDemo());

class ImagePickerDemo extends StatefulWidget {
  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {
  File _avatarFile;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            width: 100,
            height: 100,
            child: _avatarFile != null
                ? Image.file(_avatarFile)
                : Image(image: AssetImage('images/Hank.png'))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ImagePicker().getImage(source: ImageSource.gallery).then((val) {
              setState(() {
                _avatarFile = File(val.path);
              });
            });
          },
        ),
      ),
    );
  }
}
