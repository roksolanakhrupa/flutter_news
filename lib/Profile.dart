import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _username;

  TextEditingController _controllerUsername;
  TextEditingController _controllerEmail;
  TextEditingController _controllerPhone;

  @override
  void initState() {
    _controllerUsername = TextEditingController();
    _controllerEmail = TextEditingController();
    _controllerPhone = TextEditingController();
  }

  void updateProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Your profile is updated"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                _username = _controllerUsername.text;

                _controllerUsername.clear();
                _controllerEmail.clear();
                _controllerPhone.clear();

                Navigator.pushReplacementNamed(context, '/news', arguments: {
                  'username': _username,
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Your profile: ',
                              style: TextStyle(
                                fontSize: 25.0,
                              )),
                          Form(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TextField(
                                controller: _controllerUsername,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'username',
                                ),
                              ),
                              Divider(),
                              TextField(
                                controller: _controllerEmail,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'email',
                                ),
                              ),
                              Divider(),
                              TextField(
                                controller: _controllerPhone,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'phone',
                                ),
                              ),
                              Divider(),
                              RaisedButton(
                                  child: Text('Update profile'),
                                  onPressed: updateProfile),
                            ],
                          ))
                        ])))));
  }
}
