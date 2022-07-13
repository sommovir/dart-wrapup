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

  void getAccountFromServer() async {
    print("Entra");
    final url = Uri.parse('http://lin.java-injection.dev/test/accounts');
    print("Entra2");

    //Crea la richiesta http all'url
    final res = await http.get(url);

    print("res: ${res.body}");
    print("Qui");

    //decodifica il body della response in formato json
    var accountJson = json.decode(res.body);

    //per ogni elemento lo fetcha e lo aggiunge alla lista
    for (var p in accountJson) {
      DBManager.getInstance()?.userTable[p.username] = Account.fromJson(p);
      print("Aggiungo");
    }

    print("LUNGOOOOOOOOOOOOOOOOO ${DBManager.getInstance()?.userTable.length}");
  }
}
