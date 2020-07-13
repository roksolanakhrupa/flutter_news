import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class TakePhoto extends StatefulWidget {
  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  var imageFile;
  String filePath;

  final String url = "https://flutter-test.redentu.com";
  ImagePicker imPicker = ImagePicker();

  Future takeCameraPhoto() async {
    var pickedFile = await imPicker.getImage(source: ImageSource.camera);
    this.setState(() {
      filePath = pickedFile.path;
      imageFile = File(pickedFile.path);
    });
  }

  void sendPhoto(context) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('picture', filePath));
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });

          return AlertDialog(
            title: Text("Please, wait"),
            content: Text("Your image is uploading"),
          );
        });
    await request.send().whenComplete(() => {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: new Text("Your photo has been sent"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Thank you!"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          )
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                  child: imageFile == null
                      ? Text("no image")
                      : Image.file(imageFile)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: takeCameraPhoto,
                    child: Text('Take Photo'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      sendPhoto(context);
                    },
                    child: Text('Send photo'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
