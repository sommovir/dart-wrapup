import 'dart:io';
import 'package:crappy_steam/ConsoleColors.dart';

bool connected = false;
void main() {
  connectDB();
}

void connectDB() {
  print("[DB] connecting to database..");
  sleep(Duration(seconds: 2));
  connected = true;
  print(
      '[DB] connection to database: ${ConsoleColors.GREEN.code} SUCCESS ${ConsoleColors.RESET.code}');
}
