import 'package:contactbook/model/contact.dart';
import 'dart:async';
import 'package:contactbook/model/database_helper.dart';

class Contact_Controller {
  DatabaseHelper connection = new DatabaseHelper();

//Insertion
  Future<int> saveContact(Contact contact) async {
    var dbClient = await connection.database;
    int res = await dbClient.insert("Contact", contact.toMap());
    return res;
  }

  //Updation
  Future<int> updateContact(int id, Contact contact) async {
    var dbClient = await connection.database;
    var name = contact.name;
    var contactNo = contact.contactNo;
    int res = await dbClient.rawUpdate("UPDATE Contact SET name = '$name', contactNo = '$contactNo' WHERE id = ?", [id]);
    //int res = await dbClient.update("Contact", contact.toMap(), where: "id = ?", whereArgs: [id]);
    return res;
  }

  //deletion
  Future<int> deleteContact(int contact) async {
    var dbClient = await connection.database;
    int res = await dbClient.rawDelete('DELETE FROM Contact WHERE id = ?', [contact]);
    return res;
  }

  Future<Contact> checkContact(String name, String contactNo) async {
    var dbClient = await connection.database;
    var res = await dbClient.rawQuery("SELECT * FROM Contact WHERE name = '$name' and contactNo = '$contactNo'");

    if (res.length > 0) {
      return new Contact.fromMap(res.first);
    }
    return null;
  }

  Future<List<Contact>> getAllContact() async {
    var dbClient = await connection.database;
    var res = await dbClient.query("Contact");

    List<Contact> list =
    res.isNotEmpty ? res.map((c) => Contact.fromMap(c)).toList() : null;
    return list;
  }

  Future<List<Contact>> searchContact(String name, String contactNo) async {

    var dbClient = await connection.database;
    var res = await dbClient.rawQuery("SELECT * FROM Contact WHERE name LIKE '$name%' OR contactNo LIKE '$contactNo%'");

    List<Contact> list =
    res.isNotEmpty ? res.map((c) => Contact.fromMap(c)).toList() : null;
    return list;
  }

}