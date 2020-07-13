import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController _controllerLogin;
  TextEditingController _controllerPassword;

  final String DEFAULT_EMAIL = "User";
  final String DEFAULT_PASSWORD = "123456";

  @override
  void initState() {
    _controllerLogin = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  void login() {
    if ((_controllerLogin.text == DEFAULT_EMAIL) &&
        (_controllerPassword.text == DEFAULT_PASSWORD)) {
      Navigator.pushReplacementNamed(context, '/news',
          arguments: {'username': 'User'});
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content:  Text("Incorrect login or password"),
            actions: <Widget>[
               FlatButton(
                child: Text("Try again"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: EdgeInsets.all(15),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controllerLogin,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Login',
              ),
            ),
            Divider(),
            TextField(
              controller: _controllerPassword,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            RaisedButton(
              onPressed: login,
              child: Text("Login"),
            )
          ],
        ),
      ),
    )));
  }
}
