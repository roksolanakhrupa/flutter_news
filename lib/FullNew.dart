import 'package:flutter/material.dart';

class FullNew extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;

  FullNew({this.title, this.content, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BackButton(
                color: Colors.black,
              ),
              Image.network(
                imageUrl,
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: LinearProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
              ),
              Divider(
                color: Colors.grey[400],
              ),
              Text(title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold)),
              Text(content,
                  style: TextStyle(color: Colors.grey[700], fontSize: 20.0)),
            ],
          ),
        ))));
  }
}
