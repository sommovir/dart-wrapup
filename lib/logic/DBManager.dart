import 'dart:collection';

import 'package:crappy_steam/Game.dart';
import 'package:crappy_steam/exceptions/PsswdWrong.dart';
import 'package:crappy_steam/exceptions/UsernameNotExistingException.dart';
import 'package:crappy_steam/exceptions/UsernameExistingException.dart';
import 'package:crappy_steam/logic/HTTPManager.dart';
import 'package:http/http.dart';

import 'Account.dart';

class DBManager {
  static DBManager? _instance; //sperando sia null

  DBManager._();  //si è strano ma è un costruttore privato

  Future<void> init() async{
    print("faccio la query al db..");
    await HTTPManager.getInstance()!.getAccountFromServer().then(

        (accounts) {
          for (var p in accounts) {
            userTable[p.username] = p;
          }
        }
    );


  }

  Map<String, Account> userTable = HashMap();

  int getAccountsSize(){
    return userTable.length;
  }

  //PATTERN SINGLETON
  static DBManager? getInstance() =>
    _instance ??= DBManager._(); //if _instance è nullo usa il costruttore priv.

  bool userNameExisting(String username) => userTable.containsKey(username);

  void register(String username, String password) {
    if (userNameExisting(username)) {
      throw UsernameExistingException("L'username già esiste");
    }
    List<Game> games = [];
    Account account = Account(1, username, password, 100, games);
    userTable[username] = account; //tradotto in java
    //userTable.put(username, account);
    print("[INFO] account: $account inserito correttamente");
  }

  String? login(String username, String password) {
    if (!userNameExisting(username)) {
      throw UsernameNotExistingException("L'username non esiste");
    }
    if (!(userTable[username]?.password == password)) {
      throw PsswdWrong("Password inserita incorretta");
    }
    return username;
  }

  Account? getAccountByUsername(String username) => userTable[username] ??=
      throw Exception("[ERROR] il nome utente $username non esiste");

  void printStatus() {
    print("server online");
  }
}
