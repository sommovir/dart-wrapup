class DBManager {
  static DBManager? _instance; //sperando sia null

  DBManager._(); //si è strano ma è un costruttore privato

  //PATTERN SINGLETON
  static DBManager? getInstance() {
    _instance ??= DBManager._(); //if _instance è nullo usa il costruttore priv.
    return _instance;
  }
}
