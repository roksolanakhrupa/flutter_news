import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'NewsPage.dart';
import 'Profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/news',
      routes: {
        '/login':(context) => LoginPage(),
        '/news':(context) => NewsPage(),
        '/profile':(context)=>Profile(),

      },
    );
  }
}

