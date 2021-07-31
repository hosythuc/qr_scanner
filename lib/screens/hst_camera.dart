import 'package:QR_Scanner/shared/menu.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HSTCamera extends StatefulWidget {
  final CameraDescription camera;
  const HSTCamera({Key key,  this.camera}) : super(key: key);
  @override
  State createState() => _CameraState();
}

class _CameraState extends State<HSTCamera> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;


  @override
  void initState() {
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium
    );
    super.initState();

    _initializeControllerFuture = _controller.initialize();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child:  FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview.
                  return CameraPreview(_controller);
                } else {
                  // Otherwise, display a loading indicator.
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Menu(),
              ),
              QrImage(
                data: "12232322",
                version: QrVersions.auto,
                size: 200.0,
              ),
            ],
          ),
        ],
      )// You must wait until the controller is initialized before displaying the
// camera preview. Use a FutureBuilder to display a loading spinner until the
// controller has finished initializing.

    );
  }
}