import 'dart:collection';
import 'dart:convert';

import 'package:crappy_steam/Game.dart';
import 'package:crappy_steam/exceptions/PsswdWrong.dart';
import 'package:crappy_steam/exceptions/UsernameNotExistingException.dart';
import 'package:crappy_steam/exceptions/UsernameExistingException.dart';
import 'package:crappy_steam/logic/HTTPManager.dart';
import 'package:http/http.dart' as http;

import 'Account.dart';

class DBManager {
  static DBManager? _instance; //sperando sia null

  DBManager._(); //si è strano ma è un costruttore privato

  Future<void> init() async {
    print("faccio la query al db..");
    await HTTPManager.getInstance()!.getAccountFromServer().then((accounts) {
      for (var p in accounts) {
        userTable[p.username] = p;
      }
    });
  }

  Future<void> reload() async {
    Map<String, Account> user = HashMap();

    await HTTPManager.getInstance()!.getAccountFromServer().then((accounts) {
      for (var p in accounts) {
        print("carico\n");
        try {
          if (userTable[p.username] != p) userTable[p.username] = p;
          if (!userTable.containsValue(p)) {
            userTable[p.username] = p;
          }
        } catch (e) {}
      }
    });

    for (Account a in userTable.values) {}
  }

  Map<String, Account> userTable = HashMap();

  int getAccountsSize() {
    return userTable.length;
  }

  Future<void> deleteAccount(Account account) async {
    String uri = "http://lin.java-injection.dev/test/accounts/${account.id}";
    //TODO
  }

  void printUser() {
    String x = "";
    for (var p in userTable.values) {
      x += "${p.toString()}\n";
    }
    print(x);
  }

  //PATTERN SINGLETON
  static DBManager? getInstance() => _instance ??=
      DBManager._(); //if _instance è nullo usa il costruttore priv.

  bool userNameExisting(String username) => userTable.containsKey(username);

  Future<int> register(String username, String password) async {
    if (userNameExisting(username)) {
      throw UsernameExistingException("L'username già esiste");
    }
    List<Game> games = [];
    Account account = Account(1, username, password, 100, games);
    //tradotto in java
    //userTable.put(username, account);
    final jsonText = jsonEncode({"Account": account},
        toEncodable: (Object? value) => value is Account
            ? Account.toJson(value)
            : throw UnsupportedError("Errore nella creazione del Json"));
    print(jsonText);

    final uri = Uri.parse("http://lin.java-injection.dev/register");

    final response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': account.id,
          'username': account.username,
          'password': account.password,
          'money': account.money,
          'games': null,
        }));

    print(response.statusCode);

    print("[INFO] account: $account inserito correttamente");
    int id = int.parse(response.body);
    account.setId(id);
    userTable[username] = account;
    return int.parse(response.body);
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

  Future<void> addMoney(Account account, int money) async {
    Uri uri = Uri.parse(
        "https://lin.java-injection.dev/test/accounts/${account.id}/addmoney/$money");
    print(
        "URI________________________________-https://lin.java-injection.dev/test/accounts/${account.id}/addmoney/$money");

    final response = await http
        .patch(uri,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{}))
        .then((value) => print(value.body));
  }
}
