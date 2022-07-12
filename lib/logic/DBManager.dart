import 'dart:collection';

import 'package:crappy_steam/logic/Account.dart';
import 'package:crappy_steam/exceptions/UsernameExistingException.dart';
import 'package:http/http.dart';

class DBManager {
  static DBManager? _instance; //sperando sia null

  DBManager._(); //si è strano ma è un costruttore privato
  Map<String, Account> userTable = HashMap();

  //PATTERN SINGLETON
  static DBManager? getInstance() {
    _instance ??= DBManager._(); //if _instance è nullo usa il costruttore priv.
    return _instance;
  }

  bool userNameExisting(String username) => userTable.containsKey(username);

  void register(String username, String password) {
    if (userNameExisting(username)) {
      throw UsernameExistingException("L'username già esiste");
    }
    Account account = Account(1); //TODO completare logica creazione account
    userTable[username] = account; //tradotto in java
    //userTable.put(username, account);
    print("[INFO] account: $account inserito correttamente");
  }

  Account? getAccountByUsername(String username) => userTable[username] ??=
      throw Exception("[ERROR] il nome utente $username non esiste");

  void printStatus() {
    print("server online");
  }
}
