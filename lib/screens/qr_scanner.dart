import 'dart:io';
import 'dart:developer' as developer;

import 'package:QR_Scanner/models/Code.dart';
import 'package:QR_Scanner/screens/gallery/qr_gallery_image.dart';
import 'package:QR_Scanner/screens/qr_details.dart';
import 'package:QR_Scanner/shared/empty_app_bar.dart';
import 'package:QR_Scanner/shared/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (controller != null) {
      controller.scannedDataStream.first;
      controller.scannedDataStream.listen(_scannedDataStream);
    }
  }
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    else {
      controller.resumeCamera();
    }
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Stack(
        children: [
          _buildQRView(),
          Align(
            alignment: Alignment.topCenter,
            child: Menu(clickMenuItem: (menuType) {
              if (menuType == MenuType.Flash) {
                controller.toggleFlash();
              }
              if (menuType == MenuType.FlipCamera) {
                controller.flipCamera();
              }
              if (menuType == MenuType.Gallery) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => QRGalleryImage()));
              }
            },),
          )
        ],
      ),
    );
  }

  Widget _buildQRView() {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;
    return QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderWidth: 10,
          borderLength: 30,
          cutOutSize: scanArea,
        ),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
      setState(() {
        this.controller  = controller;
      });
      controller.scannedDataStream.listen(_scannedDataStream);
  }

  void _scannedDataStream(Barcode event) {
    setState(() async {
      result = event;
      if (result != null) {
        var code = Code(type: describeEnum(result.format), code: result.code);
        if (Platform.isAndroid) {
          controller.pauseCamera();
        }
        else {
          controller.resumeCamera();
        }
        developer.log(code.code);
        await Navigator.push(context, MaterialPageRoute(builder: (context) => QrDetails(code: code)));
        controller.resumeCamera();
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      print("No permision");
    }
  }
}