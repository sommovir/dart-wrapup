import 'dart:convert';
import 'package:crappy_steam/logic/Account.dart';
import 'package:http/http.dart' as http;
import '../server/person.dart';

 main(List<String> arguments) async {
  final url = Uri.parse('http://lin.java-injection.dev/test/accounts');

  //Crea la richiesta http all'url
  final res = await http.get(url);

  print("res: ${res.body}");

  var accounts = [];

  //decodifica il body della response in formato json
  var accountJson = json.decode(res.body);

  //per ogni elemento lo fetcha e lo aggiunge alla lista
  for (var p in accountJson) {
    accounts.add(Account.fromJson(p));
  }

  print("--------------------------------------------------------------------");

  for (Account a in accounts) {
    print(a.toString());
  }

  //test
  print('STATUS CODE => ${res.statusCode}\n $accountJson');
}
