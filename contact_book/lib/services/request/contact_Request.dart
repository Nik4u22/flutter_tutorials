import 'dart:async';

import 'package:contactbook/model/contact.dart';
import 'package:contactbook/controller/contact_Controller.dart';

class Contact_Request {

  Contact_Controller con = new Contact_Controller();

  Future<int> create_Contact(Contact contact) {
    var result = con.saveContact(contact);
    return result;
  }

  Future<int> update_Contact(int id, Contact contact) {
    print("1");
    var result = con.updateContact(id, contact);
    return result;
  }

  Future<List<Contact>> get_Contact() {
    var result = con.getAllContact();
    return result;
  }

  Future<List<Contact>> search_Contact(Contact contact) {
    var result = con.searchContact(contact.name, contact.contactNo);
    return result;
  }

  Future<int> delete_Contact(int contact) {
    var result = con.deleteContact(contact);
    return result;
  }
}