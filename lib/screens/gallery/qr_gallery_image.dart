import 'dart:convert';
import 'dart:io';

import 'package:QR_Scanner/models/ImageGallery.dart';
import 'package:flutter/material.dart';
import 'package:storage_path/storage_path.dart';
import 'package:transparent_image/transparent_image.dart';
class QRGalleryImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRGalleryImage();
}

class _QRGalleryImage extends State<QRGalleryImage> {
  String imagePath = "";
  List<Color> listBorderImageColor = [];
  int prevSelected = -1;
  double opacitySelectButton = 0.0;
  double heightContent = 0;
  AppBar appBar;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    appBar = AppBar(
      title: Text("Gallery"),
      centerTitle: true,
    );
    heightContent = MediaQuery.of(context).size.height - appBar.preferredSize.height;

    return  Scaffold(
      appBar: appBar,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: heightContent - 43,
              child: FutureBuilder(
                future: StoragePath.imagesPath,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    listBorderImageColor.add(Colors.white);
                    var response = jsonDecode(snapshot.data);
                    var imageList = response as List;
                    //List<ImageGallery> list = imageList.map<ImageGallery>((json) => ImageGallery.fromJson(json)).toList();
                    List<ImageGallery> list = imageList.map<ImageGallery>((json) {
                      return ImageGallery.fromJson(json);
                    }).toList();
                    return Container(
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            listBorderImageColor.add(Colors.white);
                            ImageGallery imageModel = list[index];
                            return Container(
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(color: listBorderImageColor[index], spreadRadius: 3)
                                          ]
                                      ),
                                      child: GestureDetector(
                                        onTap: () => _onSelectedItem(index),
                                        child: FadeInImage(
                                          image: FileImage(
                                            File(imageModel.files[0]),
                                          ),
                                          placeholder: MemoryImage(kTransparentImage),
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            );
                          }
                      ),
                    );
                  }
                  else {
                    return Container();
                  }
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Opacity(
                  opacity: opacitySelectButton,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                    child: RaisedButton(
                      onPressed: () {

                      },
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Center(
                        child: Text("Select", style: TextStyle(color: Colors.white, fontSize: 18.0),),
                      ),
                    ),
                  )
              )
            )
          ],
        ),
      )
    );
  }

  Future<void> getImagePath() async {
    String imagespath = "";
    imagespath = await StoragePath.imagesPath;
    var imageList = jsonDecode(imagespath) as List;
    print(imageList);
  }

  void _onSelectedItem(int index) {
    setState(() {
      if (prevSelected == index) {
        prevSelected = -1;
        if (listBorderImageColor[prevSelected] == Colors.white) {
          listBorderImageColor[prevSelected] = Colors.blue[400];
        }
        else {
          listBorderImageColor[prevSelected] = Colors.white;
        }
      }
      if (prevSelected != -1) {
        listBorderImageColor[prevSelected] = Colors.white;
      }
      prevSelected = index;
      listBorderImageColor[index] = Colors.blue[400];
      heightContent = MediaQuery.of(context).size.height - appBar.preferredSize.height - 160;
      opacitySelectButton = 1.0;
    });
  }
}