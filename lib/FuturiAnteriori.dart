import 'dart:io';
import 'package:crappy_steam/ConsoleColors.dart';

bool connected = false;
void main() async {
  var msg = isConnected();
  connectDB();
  print(await "connected = $connected");
  var lista = await query();
  lista.forEach((element) {
    print(element);
  });
}

Future<String> isConnected() async {
  int seconds = 0;
  while (true) {
    if (connected) {
      return Future.value("La connessione al database è attiva !");
    }
    sleep(Duration(seconds: 1));
    print("waiting for connection.. $seconds");
    seconds++;
  }
}

Future<void> connectDB() async {
  print("[DB] connecting to database..");
  sleep(Duration(seconds: 4));
  print(
      '[DB] connection to database: ${ConsoleColors.GREEN.code} SUCCESS ${ConsoleColors.RESET.code}');

  connected = true;
  sleep(Duration(seconds: 2));
  print("[DB] writing log..");
  sleep(Duration(seconds: 3));
  print(
      '[DB] log written: ${ConsoleColors.GREEN.code} SUCCESS ${ConsoleColors.RESET.code}');
}

Future<List<String>> query() async {
  assert(connected);
  print("[DB] SELECT * FROM PERSON ..");
  //sleep(Duration(seconds: 2));
  print(
      '[DB] Query performed: ${ConsoleColors.GREEN.code} SUCCESS ${ConsoleColors.RESET.code}');
  return ["Gino", "Mario", "Alfonso"];
}
