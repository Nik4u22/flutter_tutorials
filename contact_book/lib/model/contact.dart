class Contact {

  int _id;
  String _name;
  String _contactNo;

  Contact(this._name, this._contactNo);

  Contact.fromMap(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._contactNo = obj['contactNo'];
  }

  String get name => _name;
  String get contactNo => _contactNo;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["name"] = _name;
    map["contactNo"] = _contactNo;
    return map;
  }
  
}