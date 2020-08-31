import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gestures Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget{
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  void _showDialog(BuildContext context, message) {

    showDialog(
      context: context, builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Message"),
          content: new Text(message),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
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
      appBar: AppBar(
        title: Text("Flutter Gestures Demo"),
      ),
      body: Center(
          child: GestureDetector(
              onTap: () {
                _showDialog(context, 'OnTap Gesture');
              },
              onDoubleTap: (){
                _showDialog(context, 'Double Tap Gesture');
              },
              onLongPress: (){
                _showDialog(context, 'LongPress Tap Gesture');
              },
              child: Text( 'Hello World', )
          ),

      ),
    );
  }
}
