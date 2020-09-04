import 'package:contactbook/services/response/contact_Response.dart';
import 'package:flutter/material.dart';
import 'package:contactbook/model/contact.dart';

class Contact_Delete extends StatefulWidget {
  @override
  _ContactDeleteState createState() => new _ContactDeleteState();
}

class _ContactDeleteState extends State<Contact_Delete> implements Search_ContactCallBack, Delete_ContactCallBack, Get_ContactCallBack{

  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _searchTextController = TextEditingController();
  Delete_ContactResponse _responseDelete;
  Search_ContactResponse _responseSearch;
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

  _ContactDeleteState() {
    _responseSearch = new Search_ContactResponse(this);
    _responseDelete = new Delete_ContactResponse(this);
    _responseGet = new Get_ContactResponse(this);
    listContact = new List<Contact>();
    _responseSearch.doSearch(_searchTextController.text);
    _responseGet.doGet();
  }

  void _delete(int id) {
    final form = formKey.currentState;
    print(form);
    print(id);
    /*final form = scaffoldKey.currentState;
    print(form);
    print(id);
    setState(() {
      _isLoading = true;
      _responseDelete.doDelete(id);
    });*/
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
      padding: const EdgeInsets.fromLTRB(3, 15, 0,0),
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
          new Form(
            key: formKey,
            child: new Expanded(
              child: dataBody(),
            ),
          ),
        ],
      ),
    );
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


