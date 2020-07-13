import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterredentu/QR_generator.dart';
import 'New.dart';
import 'NewCard.dart';
import 'Profile.dart';
import 'TakePhoto.dart';

class NewsPage extends StatefulWidget {
  @override
  NewsPageState createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  List<New> news = List();
  String username;
  String buttonText;
  bool isSignIn = false;
  Color textColor = Colors.black;

  login() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Do you want to log out?"),
          actions: <Widget>[
            FlatButton(
              child: Text("yes"),
              onPressed: () {
                username = "none";
                isSignIn = false;
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/news');
              },
            ),
            FlatButton(
              child: Text("no"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  getUsername() {
    if (ModalRoute.of(context).settings.arguments != null) {
      Map data = Map();
      data = ModalRoute.of(context).settings.arguments;
      username = data['username'];
    } else {
      username = "none";
    }
  }

  setButtonText() {
    if (username == "none") {
      isSignIn = false;
      buttonText = "LOGIN";
      textColor = Colors.grey[100];
    } else {
      isSignIn = true;
      buttonText = "LOGOUT";
      textColor = Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    getUsername();
    setButtonText();

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              padding: EdgeInsets.all(15.0),
              child: Column(children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 130.0,
                      child: Text("$username",
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0)),
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton(
                          color: Colors.grey[300],
                          onPressed: () {
                            isSignIn ? logout() : login();
                          },
                          child: Text(buttonText),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.0),
                        ),
                        FlatButton(
                          color: Colors.grey[300],
                          onPressed: () {
                            if (isSignIn) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile()));
                            }
                          },
                          child: Text(
                            'PROFILE',
                            style: TextStyle(color: textColor),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                FutureBuilder(
                  builder: (context, snapshot) {
                    var showData = jsonDecode(snapshot.data.toString());
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: showData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NewCard(
                            title: showData[index]['title'],
                            imageUrl: showData[index]['imageUrl'],
                            content: showData[index]['content']);
                      },
                    );
                  },
                  future: DefaultAssetBundle.of(context)
                      .loadString("res/news.json"),
                ),
              ]))),
      floatingActionButton: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TakePhoto()),
                      );
                    },
                    child: Icon(Icons.photo_camera)),
              ),
              FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QrGenerator()),
                    );
                  },
                  child: Text(
                    "QR",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.5),
                  )),
            ],
          )),
    );
  }
}
