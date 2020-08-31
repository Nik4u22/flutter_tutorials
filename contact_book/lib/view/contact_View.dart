import 'package:contactbook/services/response/contact_Response.dart';
import 'package:flutter/material.dart';
import 'package:contactbook/model/contact.dart';

class Contact_View extends StatefulWidget {
  @override
  _ContactViewState createState() => new _ContactViewState();
}

class _ContactViewState extends State<Contact_View> implements Create_ContactCallBack,Get_ContactCallBack,Delete_ContactCallBack{

  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _name, _contactNo;

  Create_ContactResponse _responseCreate;
  Get_ContactResponse _responseGet;
  Delete_ContactResponse _responseDelete;
  List<Contact> listContact;

  _ContactViewState() {
    _responseCreate = new Create_ContactResponse(this);
    _responseGet = new Get_ContactResponse(this);
    _responseDelete = new Delete_ContactResponse(this);
    listContact = new List<Contact>();
    _responseGet.doGet();
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _responseCreate.doCreate(_name, _contactNo);
      });
    }
  }

  void _delete(int id) {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        _responseDelete.doDelete(id);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Id')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Contact No')),
          DataColumn(label: Text('Action')),
        ],
        rows: listContact?.map(
          ((element) => DataRow(
            cells: <DataCell>[
              DataCell(Text(element.id.toString())), //Extracting from Map element the value
              DataCell(Text(element.name)),
              DataCell(Text(element.contactNo)),
              DataCell( new IconButton(
                icon: const Icon(Icons.delete_forever,
                    color: const Color(0xFF167F67)),
                onPressed: () => _delete(element.id),
                alignment: Alignment.centerLeft,
              )),
            ],
          )),
        )?.toList() ?? [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    var saveBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Save"),
      color: Colors.green,
    );
    var contactForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _name = val,
                  decoration: new InputDecoration(labelText: "Name"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _contactNo = val,
                  decoration: new InputDecoration(labelText: "Contact No"),
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
      ),
      key: scaffoldKey,
      body: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          contactForm,
          Expanded(
            child : dataBody(),
          ),
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
      _responseGet.doGet();
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

  @override
  void onGetContactError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onGetContactSuccess(List<Contact> contact) async {

    if(contact != null){
      // TODO: implement onLoginSuccess
      listContact = contact;
      setState(() {});
    }else{
    }

  }

  @override
  void onDeleteContactError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onDeleteContactSuccess(int contact) async {

    if(contact > 0){
      _responseGet.doGet();
      // TODO: implement onLoginSuccess
      _showSnackBar("Contact removed!");
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


