import 'package:flutter/material.dart';
import 'FullNew.dart';

class NewCard extends StatelessWidget {
  String content;
  String title;
  String imageUrl;

  NewCard({this.title, this.content, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.grey[200],
        child: Container(
          padding: EdgeInsets.all(7.0),
          child: GestureDetector(
              child: Row(
                children: <Widget>[
                  Image.network(
                    imageUrl,
                    width: 70.0,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                  ),
                  Text(title,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FullNew(
                      title: title, content: content, imageUrl: imageUrl);
                }));
              }),
        ),
      ),
    );
  }
}
