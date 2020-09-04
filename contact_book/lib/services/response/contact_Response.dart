import 'package:contactbook/services/request/contact_Request.dart';
import 'package:contactbook/model/contact.dart';

abstract class Create_ContactCallBack {
  void onCreateContactSuccess(int contact);
  void onCreateContactError(String error);
}

abstract class Update_ContactCallBack {
  void onUpdateContactSuccess(int contact);
  void onUpdateContactError(String error);
}

abstract class Get_ContactCallBack {
  void onGetContactSuccess(List<Contact> contact);
  void onGetContactError(String error);
}

abstract class Search_ContactCallBack {
  void onSearchContactSuccess(List<Contact> contact);
  void onSearchContactError(String error);
}

abstract class Delete_ContactCallBack {
  void onDeleteContactSuccess(int contact);
  void onDeleteContactError(String error);
}

class Create_ContactResponse {
  Create_ContactCallBack _callBackCreate;
  Contact_Request contact_Request = new Contact_Request();
  Create_ContactResponse(this._callBackCreate);

  doCreate(String name, String contactNo) {
    print("name ="+name+" contact No="+contactNo);
    var fido = Contact(name, contactNo);

    contact_Request
        .create_Contact(fido)
        .then((contact) => _callBackCreate.onCreateContactSuccess(contact))
        .catchError((onError) => _callBackCreate.onCreateContactError(onError.toString()));
  }
}

class Update_ContactResponse {
  Update_ContactCallBack _callBackCreate;
  Contact_Request contact_Request = new Contact_Request();
  Update_ContactResponse(this._callBackCreate);

  doUpdate(int id, String name, String contactNo) {
    print("name ="+name+" contact No="+contactNo);
    var fido = Contact(name, contactNo);
    contact_Request
        .update_Contact(id, fido)
        .then((contact) => _callBackCreate.onUpdateContactSuccess(contact))
        .catchError((onError) => _callBackCreate.onUpdateContactError(onError.toString()));
  }
}

class Get_ContactResponse {
  Get_ContactCallBack _callBackGet;
  Contact_Request contact_Request = new Contact_Request();
  Get_ContactResponse(this._callBackGet);

  doGet() {
    contact_Request
        .get_Contact()
        .then((contact) => _callBackGet.onGetContactSuccess(contact))
        .catchError((onError) => _callBackGet.onGetContactError(onError.toString()));
  }
}

class Search_ContactResponse {
  Search_ContactCallBack _callBackSearch;
  Contact_Request contact_Request = new Contact_Request();
  Search_ContactResponse(this._callBackSearch);

  doSearch(String searchText) {
    var fido = Contact(searchText, searchText);
    contact_Request
        .search_Contact(fido)
        .then((contact) => _callBackSearch.onSearchContactSuccess(contact))
        .catchError((onError) => _callBackSearch.onSearchContactError(onError.toString()));
  }
}

class Delete_ContactResponse {
  Delete_ContactCallBack _callBackDelete;
  Contact_Request contact_Request = new Contact_Request();
  Delete_ContactResponse(this._callBackDelete);

  doDelete(int id) {

    contact_Request
        .delete_Contact(id)
        .then((contact) => _callBackDelete.onDeleteContactSuccess(contact))
        .catchError((onError) => _callBackDelete.onDeleteContactError(onError.toString()));
  }
}