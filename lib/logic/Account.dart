class Account {
  final int _id;
  final String _username;
  final String _password;

  Account(this._id, this._username, this._password);

  int get id => _id;
  String get username => _username;
  String get password => _password;
  //set id(int id) => _id = id;
}
