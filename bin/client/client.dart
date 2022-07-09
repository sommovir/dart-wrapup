import 'dart:convert';
import 'package:http/http.dart' as http;
import '../server/person.dart';

Future<void> main(List<String> arguments) async {
  final url = Uri.parse('http://lin.java-injection.dev/test');

  //Crea la  richiesta http all'url
  final res = await http.get(url);

  print("res: ${res.body}");

  //var people = [];

  //decodifica il body della response in formato json
  // var personsJson = json.decode(res.body);

  //per ogni elemento lo fetcha e lo aggiunge alla lista
  // for (var p in personsJson) {
  //   people.add(Person.fromJson(p));
  // }

  //print('STATUS CODE => ${res.statusCode}\n $personsJson');
}
