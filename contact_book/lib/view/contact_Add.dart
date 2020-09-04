import 'package:contactbook/services/response/contact_Response.dart';
import 'package:flutter/material.dart';

class Contact_Add extends StatefulWidget {
  @override
  _ContactAddState createState() => new _ContactAddState();
}

class _ContactAddState extends State<Contact_Add> implements Create_ContactCallBack {

  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  int _id;
  String _name, _contactNo;

  Create_ContactResponse _responseCreate;

  _ContactAddState() {
    _responseCreate = new Create_ContactResponse(this);
  }

  void _submit() {
    final form = formKey.currentState;
    print(form);
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _responseCreate.doCreate(_name, _contactNo);
        form.reset();
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    var saveBtn = new Padding(
      padding: const EdgeInsets.fromLTRB(132, 2, 132, 10),
      child: RaisedButton(
        onPressed: _submit,
        color: Colors.green,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.green)
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Save',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              )
            ],
          ),
        ),
      ),
    );

    var contactForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.fromLTRB(30, 90, 30, 0),
                child: new TextFormField(
                  onSaved: (val) => _name = val,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0),
                      hintText: "Name",
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: new TextFormField(
                  onSaved: (val) => _contactNo = val,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      //contentPadding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 15.0),
                      hintText: "Contact No",
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
                ),
              )
            ],
          ),
        ),
        saveBtn
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Contact Book"),
        backgroundColor: Colors.green,
      ),
      key: scaffoldKey,
      body: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          contactForm,
        ],
      ),
    );
  }

  @override
  void onCreateContactError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onCreateContactSuccess(int contact) async {

    if(contact > 0){
      // TODO: implement onLoginSuccess
      //_responseGet.doGet();
      _showSnackBar("Contact saved!");
      _showSnackBar("Contact saved!");
      setState(() {
        _isLoading = false;
      });
    }else{
      // TODO: implement onLoginSuccess
      _showSnackBar("Failed, please check data");
      setState(() {
        _isLoading = false;
      });
    }
  }
}


