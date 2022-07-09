import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'person.dart';

final _router = Router()
  ..get('/', _rootHandler)
  ..get('/json_simple', _jsonSimpledata)
  ..get('/json_complex', _jsonFromClass)
  ..get('/<message>', _echoHandler);

Response _rootHandler(Request req) {
  return Response.ok('Hello World! => root Handler');
}

Response _jsonSimpledata(Request request){

  final simpleData = {
    "Name" : "Gennaro",
    "Surname" : "Fiore",
    "age" : 900
  };

  final jsonText = json.encode(simpleData);
  return Response.ok(jsonText);
}

Response _jsonFromClass(Request req){
  var p1 = Person("Bruh", "lmao", 90);
  var p2 = Person("Fiorella", "Donato", 123);
  final jsonText = jsonEncode({'Persona1' : p1, 'Persona2' : p2},
    toEncodable: (Object? value) => value is Person ? Person.toJson(value) : throw UnsupportedError("bro non va")
  );
  return Response.ok(jsonText);
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}


void main(List<String> args) async {
  
  final ip = 'localhost';

  // Configurazione di una pipeline per loggare tutto e aggiungere gli handler
  final handler = Pipeline()
  .addMiddleware(logRequests())
  .addHandler(_router);

  final port = 8080;
  final server = await serve(handler, ip, port);
  print('Server listening http://${server.address.host}:${server.port}');
}





