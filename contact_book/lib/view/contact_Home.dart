import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:contactbook/view/contact_Search.dart';
import 'package:contactbook/view/contact_Add.dart';
import 'package:contactbook/view/contact_Delete.dart';

class Contact_Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    void _submit(key){

      if(key == 'search'){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Contact_Search()),
        );
      }else if (key == 'add'){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Contact_Add()),
        );
      }else if(key == 'delete'){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Contact_Delete()),
        );
      }
    }

    var searchBtn = new FloatingActionButton(
      heroTag: null,
      onPressed: () {
        _submit("search");
      },
      child: Icon(Icons.search),
      backgroundColor: Colors.green,
    );

    var addBtn = new FloatingActionButton(
      heroTag: null,
      onPressed: () {
        _submit("add");
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.green,
    );

    var deleteBtn = new FloatingActionButton(
      heroTag: null,
      onPressed: () {
        _submit("delete");
      },
      child: Icon(Icons.delete),
      backgroundColor: Colors.green,
    );

    var exitBtn = new FloatingActionButton(
      heroTag: null,
      onPressed: ()=> SystemNavigator.pop(),
      child: Icon(Icons.power_settings_new),
      backgroundColor: Colors.green,
    );

    return new Scaffold(
      body: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          new Padding(
              padding: const EdgeInsets.fromLTRB(0, 180, 0, 0),
          ),
          new Container(
            height: 220.0,
            child: Icon(Icons.contact_phone, size: 200, color: Colors.green),
          ),
          new Row(
            children: [
              new Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
              ),
              new Container(
                padding: const EdgeInsets.all(10),
                height: 100.0,
                child: searchBtn,
              ),
              new Container(
                padding: const EdgeInsets.all(10),
                height: 100.0,
                child: addBtn,
              ),
              new Container(
                padding: const EdgeInsets.all(10),
                height: 100.0,
                child: deleteBtn,
              ),
              new Container(
                padding: const EdgeInsets.all(10),
                height: 100.0,
                child: exitBtn,
              ),
            ],
          ),
        ],
      ),
    );
  }
}


