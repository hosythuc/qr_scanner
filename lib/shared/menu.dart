import 'package:QR_Scanner/common/Events.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  OnClickMenuItem clickMenuItem;
  Menu({Key key, this.clickMenuItem}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final size = 30.0;

  IconData iconFlash = Icons.lightbulb_outline;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.topCenter,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: [
            GestureDetector(
              onTap: () {
                if (widget.clickMenuItem != null) {
                  widget.clickMenuItem(MenuType.Gallery);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Icon(Icons.image_outlined, color: Colors.white,size: size,),
              ),
            ),
            GestureDetector(
              onTap: () {

              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Icon(Icons.settings_rounded, color: Colors.white,size: size,),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (widget.clickMenuItem != null) {
                  widget.clickMenuItem(MenuType.Flash);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Icon(iconFlash, color: Colors.white,size: size,),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (widget.clickMenuItem != null) {
                  widget.clickMenuItem(MenuType.FlipCamera);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Icon(Icons.photo_camera_back, color: Colors.white,size: size,),
              ),
            ),
          ],
        )
      ),
    );
  }
}

enum MenuType {
  Flash,
  FlipCamera,
  Gallery,
}