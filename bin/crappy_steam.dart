import 'package:crappy_steam/Account.dart';
import 'package:crappy_steam/future_exp.dart';
import 'package:crappy_steam/crappy_steam.dart' as crappy_steam;
import 'dart:io';

const String version = "0.1";

void main(List<String> arguments) {
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


// extension RESET on Account {
//   void reset() {
//     id = -1;
//   }
// }

// extension SUM on int {
//   int sum(int b) {
//     int a = this + b;
//     return a;
//   }
// }
