import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      print(_database);
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  DatabaseHelper.internal();
  initDb() async {

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "data_contactBook.db");
    // Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('data', 'contactBook.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
    }

    var ourDatabase = await openDatabase(path, version: 1, onCreate: createTable);
    print(ourDatabase);
    return ourDatabase;
  }

  void createTable(Database database, int version) async {
    await database.execute("CREATE TABLE Contact ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "contactNo TEXT"
        ")");
  }
}