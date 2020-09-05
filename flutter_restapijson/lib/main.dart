import 'package:flutter/material.dart';
import 'package:flutterrestapijson/view/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REST JSON API',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(),
    );
  }

}


