import 'package:crappy_steam/logic/Account.dart';
import 'package:crappy_steam/future_exp.dart';
import 'package:crappy_steam/crappy_steam.dart' as crappy_steam;
import 'dart:io';

import 'package:crappy_steam/logic/DBManager.dart';

const String version = "0.1";

void main(List<String> arguments) {
  print("======== Welcome to Crappy Steam =========");
  print("                  v.$version");
  print("==========================================");
  print("");
  while (true) {
    mainMenu();

    String? line = stdin.readLineSync();

    if (line == "cs --version") {
      print("\tCrappy Steam v.$version");
    } else if (line == "status") {
      DBManager.getInstance()!.printStatus();
    } else if (line == "quit") {
      print("[INFO] bye.");
      break;
    } else {
      print("comando sconosciuto");
    }
  }
  print("programma terminato.. ");
}

void mainMenu() {
  print(" -- 1) REGISTER");
  print(" -- 2) LOGIN\n");
  print(" digita 'quit' per terminare il programma");
  print("-------------------------------------------------");
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
