import 'package:crappy_steam/Account.dart';
import 'package:crappy_steam/future_exp.dart';
import 'package:crappy_steam/crappy_steam.dart' as crappy_steam;
import 'dart:io';

const String version = "0.1";

void main(List<String> arguments) {
  int x = 6;
  print(x); 

  Account a = Account(3);
  print("1 ID di a = ${a.id}");
  a.reset();
  print("2 ID di a = ${a.id}");

  print("======== Welcome to Crappy Steam =========");
  print("                  v.$version");
  print("==========================================");
  print('Hello world: ${crappy_steam.calculate()}!');

  String? line = stdin.readLineSync();

  if (line == "cs --version") {
    print("\tCrappy Steam v.$version");
  } else {
    print("comando sconosciuto");
  }
}

extension RESET on Account {
  void reset() {
    id = -1;
  }
}

extension SUM on int {
  int sum(int b) {
    int a = this + b;
    return a;
  }
}
