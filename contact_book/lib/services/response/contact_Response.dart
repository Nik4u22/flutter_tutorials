import 'package:contactbook/services/request/contact_Request.dart';
import 'package:contactbook/model/contact.dart';

abstract class Create_ContactCallBack {
  void onCreateContactSuccess(int contact);
  void onCreateContactError(String error);
}

abstract class Get_ContactCallBack {
  void onGetContactSuccess(List<Contact> contact);
  void onGetContactError(String error);
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