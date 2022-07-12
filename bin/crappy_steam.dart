import 'package:crappy_steam/Game.dart';
import 'package:crappy_steam/logic/Account.dart';
import 'package:crappy_steam/future_exp.dart';
import 'package:crappy_steam/crappy_steam.dart' as crappy_steam;
import 'dart:io';

import 'package:crappy_steam/logic/DBManager.dart';
import 'package:crappy_steam/logic/GameManager.dart';

const String version = "0.1";
bool logged = false;

void main(List<String> arguments) {
  print("======== Welcome to Crappy Steam =========");
  print("                  v.$version");
  print("==========================================");
  print("");
  while (!logged) {
    mainMenu();

    String? line = stdin.readLineSync();

    if (line == "1") {
      try {
        registration();
      } catch (e) {
        print("[ERROR] $e");
      }
    } else if (line == "2") {
      login();
    } else if (line == "cs --version") {
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

void startGame() {
  print("Il gioco inizierà tra poco");

  for (Game? game in GameManager.getInstance()!.getGames()) {
    print(
        "Gioco n. ${game?.getId()} con nome: ${game?.getName()} con costo di ${game?.getPrice()}");
  }
  print("Selezionare il gioco:");
  String? line = stdin.readLineSync();

  if (line == "quit") {
    print("[INFO] bye.");
  }
}

void registration() {
  print("Inserire username: ");
  String? username = stdin.readLineSync();
  final RegExp regex = RegExp("[A-Za-z0-9]+");
  if (!regex.hasMatch(username!)) {
    throw Exception("Username non valido");
  }
  if (DBManager.getInstance()!.userNameExisting(username)) {
    throw Exception(
        "username $username già esistente, selezionare un diverso nome utente");
  }

  print("[INFO] username valido");
  print("[INFO] inserire una password:");
  String? pass = stdin.readLineSync();
  final RegExp regexPassword = RegExp("[0-9]+");
  if (!regexPassword.hasMatch(pass!)) {
    throw Exception("password non valida");
  }
  print("[INFO] inserire nuovamente la password:");
  String? pass2 = stdin.readLineSync();
  if (pass != pass2) {
    throw Exception("la password inserita non è uguale alla precedente");
  }
  DBManager.getInstance()!.register(username, pass);
  print("[INFO] i dati inseriti sono corretti!");
}

void login() {
  print("Inserire username: ");
  String? username = stdin.readLineSync();
  final RegExp regex = RegExp("[A-Za-z0-9]+");
  if (!regex.hasMatch(username!)) {
    throw Exception("Username non valido");
  }
  if (!DBManager.getInstance()!.userNameExisting(username)) {
    throw Exception(
        "username $username non esistente, selezionare nome utente valido");
  }

  print("[INFO] username valido");
  print("[INFO] inserire una password:");
  String? pass = stdin.readLineSync();
  final RegExp regexPassword = RegExp("[0-9]+");
  if (!regexPassword.hasMatch(pass!)) {
    throw Exception("password non valida");
  }
  DBManager.getInstance()?.login(username, pass);
  print("[INFO] login eseguito correttamente");
  logged = true;
  startGame();
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
