import 'package:QR_Scanner/models/Code.dart';
import 'package:flutter/material.dart';

class QrDetails extends StatefulWidget {
  final Code code;
  const QrDetails({Key key, this.code}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrDetailsState();
}

class _QrDetailsState extends State<QrDetails> {
  TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController(text: widget.code.code);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Details"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Infomation",
                ),
                style: TextStyle(
                  color: Colors.black
                ),

                autofocus: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 12, right: 12),
              child: Wrap(
                spacing: 20,
                runSpacing: 2.0,
                children: [
                  GestureDetector(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue,
                      ),
                      child: Icon(Icons.web_outlined),
                    )
                  ),
                  GestureDetector(
                    child: Icon(Icons.contact_phone)
                  ),
                  GestureDetector(
                    child: Icon(Icons.wifi_calling),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}