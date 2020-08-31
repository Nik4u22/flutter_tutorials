import 'package:flutter/material.dart';
import 'package:contactbook/view/contact_View.dart';

void main() => runApp(new MyApp());

final routes = {
  '/home': (BuildContext context) => new Contact_View(),
  '/': (BuildContext context) => new Contact_View(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Contact Book',
      theme: new ThemeData(primarySwatch: Colors.teal),
      routes: routes,
    );
  }
}