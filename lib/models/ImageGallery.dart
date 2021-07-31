import 'dart:developer';

class ImageGallery {
    List<String> files;
    String folderName;

    ImageGallery({this.files, this.folderName});

    ImageGallery.fromJson(Map<String, dynamic> json) {
      files = (json['files'] as List).map((e) => e.toString()).toList();
      folderName = json['folderName'] as String;
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['files'] = this.files;
      data['folderName'] = this.folderName;
      return data;
    }
}