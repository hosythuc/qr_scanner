import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QRGallery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRGallery();
}

class _QRGallery extends State<QRGallery> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Gallery"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(),
    );
  }
}