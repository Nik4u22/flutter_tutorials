import 'package:contactbook/services/response/contact_Response.dart';
import 'package:flutter/material.dart';
import 'package:contactbook/model/contact.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Contact_Search extends StatefulWidget {
  @override
  _ContactSearchState createState() => new _ContactSearchState();
}

class _ContactSearchState extends State<Contact_Search> implements Search_ContactCallBack, Update_ContactCallBack, Get_ContactCallBack {

  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  int _id;
  String _name, _contactNo;

  final TextEditingController _searchTextController = TextEditingController();

  Search_ContactResponse _responseSearch;
  Update_ContactResponse _responseUpdate;
  Get_ContactResponse _responseGet;
  List<Contact> listContact;

  searchTextListener() {
    //listContact = new List<Contact>();
    _responseSearch.doSearch(_searchTextController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _searchTextController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(searchTextListener);
  }

  _ContactSearchState() {
    _responseSearch = new Search_ContactResponse(this);
    _responseUpdate = new Update_ContactResponse(this);
    _responseGet = new Get_ContactResponse(this);
    listContact = new List<Contact>();
    _responseSearch.doSearch(_searchTextController.text);
  }

  void _submit() {
    final form = formKey.currentState;
    print(form);
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _responseUpdate.doUpdate(_id, _name, _contactNo);
        Navigator.pop(context);
      });
    }
  }

  void _showEditDialog(int id, String name, String contactNo){

    print(id);
    _id = id;
    var initialid = id.toString();
    print(initialid);
    var alertStyle = AlertStyle(

      animationType: AnimationType.fromTop,
      isCloseButton: true,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      //animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.green,
        ),
      ),
      titleStyle: TextStyle(
        //color: Colors.red,
        fontFamily: 'Montserrat',
        fontSize: 20.0,
      ),
    );

    Alert(
      context: context,
      style: alertStyle,
      title: "Edit Contact",
      content: Column(
        children: <Widget>[
          new Form(
          key: formKey,
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(2, 10, 2,10),
                    child: TextFormField(
                      //controller: _nameController,
                      initialValue: name,
                      onSaved: (val) => _name = val,
                      decoration: InputDecoration(
                        icon: Icon(Icons.account_circle),
                        //labelText: 'enter OTP',
                      ),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10,10),
                    child: TextFormField(
                      initialValue: contactNo,
                      onSaved: (val) => _contactNo = val,
                      //controller: _contactNoController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone),
                        //labelText: 'enter OTP',
                      ),
                    ),
                  ),
              /*    new Visibility(
                      visible: false,
                      child: TextFormField(
                        initialValue: id.toString(),
                        onSaved: (val) => _id = int.parse(val),
                        //controller: _contactNoController,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.phone),
                          //labelText: 'enter OTP',
                        ),
                      ),
                  ),*/
                ]
              ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          //onPressed: () => Navigator.pop(context),
          onPressed: _submit,
          child: Text(
            "Save",
            style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontSize: 20),
          ),
        )
      ]).show();
}

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.fromLTRB(1, 15, 0,0),
      child: DataTable(
        columns: [
          //DataColumn(label: Text('Id')),
          DataColumn(label: Text('Name', style: TextStyle(fontSize: 20.0))),
          DataColumn(label: Text('Contact No', style: TextStyle(fontSize: 20.0))),
          DataColumn(label: Text('', style: TextStyle(fontSize: 20.0))),
        ],
        rows: listContact?.map(
          ((element) =>
              DataRow(
                cells: <DataCell>[
                  //DataCell(Text(element.id.toString())), //Extracting from Map element the value
                  DataCell(Container(
                      width: 125, //SET width
                      child: Text(element.name, style: TextStyle(fontSize: 18.0)))),
                  DataCell(Container(
                      width: 110, //SET width
                      child: Text(element.contactNo, style: TextStyle(fontSize: 18.0)))),
                  //DataCell(Text(element.name, style: TextStyle(fontSize: 18.0))),
                  //DataCell(Text(element.contactNo, style: TextStyle(fontSize: 18.0))),
                  DataCell(new IconButton(
                    icon: const Icon(Icons.edit,
                        color: const Color(0xFF167F67)),
                    onPressed: () => _showEditDialog(element.id, element.name, element.contactNo),
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

    var searchBar = new Column(
      children: <Widget>[
        //SizedBox(height: MediaQuery.of(context).padding.top),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.0, 1.0),
                color: Colors.green,
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
              controller: _searchTextController,
              //onChanged: _ContactSearchState(),
              decoration: InputDecoration(
                //prefixIcon: Icon(HotelBookingConcept.ic_search),
                  prefixIcon: Icon(Icons.search),
                  //suffixIcon: Icon(Icons.add),
                  hintStyle:
                  TextStyle(color: Colors.black, fontSize: 18),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10)),
            ),
          ),
        ),
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
          searchBar,
          Expanded(
            child: dataBody(),
          ),
        ],
      ),
    );
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
  void onSearchContactError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onSearchContactSuccess(List<Contact> contact) async {

    if(contact != null){
      // TODO: implement onLoginSuccess
      listContact = contact;
      setState(() {});
    }else{
    }
  }

  void onUpdateContactError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onUpdateContactSuccess(int contact) async {

    if(contact > 0){
      // TODO: implement onLoginSuccess
      _responseGet.doGet();
      _showSnackBar("Contact updated!");
      _showSnackBar("Contact updated!");
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


