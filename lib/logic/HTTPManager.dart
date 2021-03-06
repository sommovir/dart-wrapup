import 'dart:convert';
import 'package:crappy_steam/logic/Account.dart';
import 'package:crappy_steam/logic/DBManager.dart';
import 'package:http/http.dart' as http;

class HTTPManager {
  static HTTPManager? _instance; //sperando sia null

  HTTPManager._(); //si è strano ma è un costruttore privato

  //PATTERN SINGLETON
  static HTTPManager? getInstance() {
    _instance ??=
        HTTPManager._(); //if _instance è nullo usa il costruttore priv.
    return _instance;
  }

  Future<List<Account>> getAccountFromServer() async {
    //print("Entra");
    final url = Uri.parse('http://lin.java-injection.dev/test/accounts');
    //print("Entra2");

    //Crea la richiesta http all'url
    final res = await http.get(url);

    //print("res: ${res.body}");
    //print("Qui");

    //decodifica il body della response in formato json
    var accountJson = json.decode(res.body);
    //print(accountJson.runtimeType);

    print("[INFO] sono stati caricati: ${accountJson.length} accounts");
    List<Account> accounts = [];
    //per ogni elemento lo fetcha e lo aggiunge alla lista
    /*
    for (var p in accountJson) {
      DBManager.getInstance()?.userTable[p.username] = Account.fromJson(p);
      print("Aggiungo");
    }*/
    for (var p in accountJson) {
      accounts.add(Account.fromJson(p));
    }

    //print("LUNGOOOOOOOOOOOOOOOOO ${DBManager.getInstance()?.userTable.length}");
    return accounts;
  }

  Future<void> printAccountFromServer() async {
    //print("Entra");
    final url = Uri.parse('http://lin.java-injection.dev/test/accounts');
    //print("Entra2");

    //Crea la richiesta http all'url
    final res = await http.get(url);

    //print("res: ${res.body}");
    //print("Qui");

    //decodifica il body della response in formato json
    var accountJson = json.decode(res.body);
    //print(accountJson.runtimeType);

    List<Account> accounts = [];
    //per ogni elemento lo fetcha e lo aggiunge alla lista
    /*
    for (var p in accountJson) {
      DBManager.getInstance()?.userTable[p.username] = Account.fromJson(p);
      print("Aggiungo");
    }*/
    for (var p in accountJson) {
      print("${p.toString()}\n");
    }
  }
}
