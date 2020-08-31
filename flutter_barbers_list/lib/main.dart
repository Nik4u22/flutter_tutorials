import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
      home: MyHomePage(title: 'Product layout demo home page'),
    );
  }
}
class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Barbers Listing")),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget>[
            ProductBox(
                name: "XMR Mens Parlour",
                description: "Best barber in khaparkheda",
                price: 1000,
                image: "barber_11.jpg"
            ),
            ProductBox(
                name: "ABC Haircut",
                description: "Best barber in khaparkheda",
                price: 800,
                image: "barber_12.jpg"
            ),
            ProductBox(
                name: "PQR Barber",
                description: "Best barber in khaparkheda",
                price: 2000,
                image: "barber_13.png"
            ),
            ProductBox(
                name: "DFR Barber",
                description: "Best barber in khaparkheda",
                price: 2000,
                image: "barber_31.jpg"
            ),
            ProductBox(
                name: "HJR Barber",
                description: "Best barber in khaparkheda",
                price: 2000,
                image: "barber_32.jpeg"
            ),
            ProductBox(
                name: "CJR Barber",
                description: "Best barber in khaparkheda",
                price: 2000,
                image: "barber_33.jpg"
            ),
            ProductBox(
                name: "MNR Barber",
                description: "Best barber in khaparkheda",
                price: 2000,
                image: "barber_41.png"
            ),
            ProductBox(
                name: "MLR Barber",
                description: "Best barber in khaparkheda",
                price: 2000,
                image: "barber_42.jpg"
            ),
            ProductBox(
                name: "ANR Barber",
                description: "Best barber in khaparkheda",
                price: 2000,
                image: "barber_43.jpg"
            ),
          ],
        )
    );
  }
}
class ProductBox extends StatelessWidget {
  ProductBox({Key key, this.name, this.description, this.price, this.image}) :
        super(key: key);
  final String name;
  final String description;
  final int price;
  final String image;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 120,
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset("assets/images/" + image),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                  this.name, style: TextStyle(
                                  fontWeight: FontWeight.bold
                              )
                              ),
                              Text(this.description), Text(
                                  "Price: " + this.price.toString()
                              ),
                            ],
                          )
                      )
                  )
                ]
            )
        )
    );
  }
}