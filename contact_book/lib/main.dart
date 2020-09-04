import 'package:flutter/material.dart';
import 'package:contactbook/view/contact_Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Book',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new Contact_Home(),
    );
  }

}


