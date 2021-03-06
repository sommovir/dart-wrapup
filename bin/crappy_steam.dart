import 'package:crappy_steam/Game.dart';
import 'package:crappy_steam/logic/Account.dart';
import 'package:crappy_steam/future_exp.dart';
import 'package:crappy_steam/crappy_steam.dart' as crappy_steam;
import 'dart:io';
import 'package:crappy_steam/logic/GameManager.dart';

import 'package:crappy_steam/logic/DBManager.dart';

const String version = "0.1";
bool logged = false;

void main(List<String> arguments) async {
  print("======== Welcome to Crappy Steam =========");
  print("                  v.$version");
  print("==========================================");
  print("");
  await DBManager.getInstance()!.init();
  String line = "";

  do {
    mainMenu();

    line = stdin.readLineSync() ?? "";

    if (line == "1") {
      try {
        await registration();
      } catch (e) {
        print("[ERROR] $e");
      }
    } else if (line == "2") {
      await login();
    } else if (line == "3") {
      DBManager.getInstance()!.printUser();
    } else if (line == "cs --version") {
      print("\tCrappy Steam v.$version");
    } else if (line == "status") {
      DBManager.getInstance()!.printStatus();
    } else if (line == "size") {
      print(
          "ci sono ${DBManager.getInstance()!.getAccountsSize()} utenti registrati ");
    } else if (line == "4") {
      DBManager.getInstance()!.userTable.clear();
      print("[INFO]Azione effettuata");
    } else if (line == "5") {
      DBManager.getInstance()!.userTable.clear();
      await DBManager.getInstance()?.reload();
    } else if (line == "quit") {
      print("[INFO] bye.");
      break;
    } else {
      print("comando sconosciuto");
    }
  } while (line != "quit");
  print("programma terminato.. ");
}

void addGame(int id) {}

void mainMenu() {
  print(" -- 1) REGISTER");
  print(" -- 2) LOGIN");
  print(" -- 3) VISUALIZZA ACCOUNT PRESENTI");
  print(" -- 4) RESET");
  print(" -- 5) RESET E REINSTALL");
  print(" digita 'quit' per terminare il programma");
  print("-------------------------------------------------");
}

Future<void> startGame(String username) async {
  await DBManager.getInstance()?.reload();
  Account? account = DBManager.getInstance()?.userTable[username];
  print("I soldi a tua disposizione sono: ${account?.money}");

  print("Possiedi i seguenti giochi: ");

  for (Game? game in account!.games) {
    print(
        "Gioco n. ${game?.getId()} con nome: ${game?.getName()} con costo di ${game?.getPrice()} con multiplayer: ${game?.multiplayer}");
  }

  print("Giochi disponibili: ");

  for (Game? game in GameManager.getInstance()!.getGames()) {
    print(
        "Gioco n. ${game?.getId()} con nome: ${game?.getName()} con costo di ${game?.getPrice()} con multiplayer: ${game?.multiplayer}");
  }

  String line;

  do {
    print(" RIMANGONO ${account.money} EURO");
    print(" -- 1) SELEZIONA UN GIOCO");
    print(" -- 2) AGGIUNGI UN GIOCO");
    print(" -- 3) ELIMINA ACCOUNT");
    print(" -- 4) AGGIUNGI SOLDI");
    print(" -- 5) VISUALIZZA ACCOUNT PRESENTI");
    print(" -- quit) STOP");
    print(" --------------------------");
    line = stdin.readLineSync() ?? "";
//non printa la lista non so why
    if (line == "1") {
      print("Seleziona uno di questi giochi: ");
      for (Game? game in account.games) {
        print("ID: ${game?.getId()} | Titolo: ${game?.getName()}");
      }

      if (account.games.isNotEmpty) {
        String selectedId = stdin.readLineSync() ?? "";
        for (Game game in account.games) {
          if (game.getId() == selectedId) {
            var index = account.games.indexOf(game);
            account.setPlayedGame(account.games.elementAt(index));
            print(
                "Ok stai giocando a (ID: ${account.playedGame?.getId()} | Titolo: ${account.playedGame?.getName()})");
          }
        }
      } else {
        print("Nessun gioco trovato");
      }
    } else if (line == "2") {
      print("Quale vuoi acquistare? ");
      for (Game? game in GameManager.getInstance()!.getGames()) {
        if (!account.games.contains(game)) {
          print("ID: ${game?.getId()} | Titolo: ${game?.getName()}");
        }
      }
      line = stdin.readLineSync() ?? "";

      for (Game? game in GameManager.getInstance()!.getGames()) {
        if (game?.getId() == line) {
          var index = GameManager.getInstance()!.getGames().indexOf(game!);
          Game x = GameManager.getInstance()!.getGames()[index];
          account.buyGames(x.getPrice(), account, game);
        }
      }
    } else if (line == "3") {
      print("DIGITARE 'DELETE' PER CONFERMARE LA CANCELLAZIONE");
      line = stdin.readLineSync() ?? "";
      if (line == "DELETE") {
        print("Account eliminato");
        await DBManager.getInstance()?.deleteAccount(account);
        break;
      } else {
        print("[INFO] AZIONE ANNULLATA");
      }
    } else if (line == "4") {
      print("Quanto vuoi aggiungere?");
      String line = stdin.readLineSync() ?? "";
      int x = int.parse(line);
      if (x <= 0) {
        print("Impossibile inserire la cifra richiesta");
      } else {
        await DBManager.getInstance()!.addMoney(account, x);
        await DBManager.getInstance()?.reload();
      }
    } else if (line == "5") {
      DBManager.getInstance()!.printUser();
    } else if (line == "status") {
      DBManager.getInstance()!.printStatus();
    } else if (line == "cs --version") {
      print("\tCrappy Steam v.$version");
    } else {
      print("comando sconosciuto");
    }
  } while (line != "quit");
}

Future<int> registration() async {
  print("Inserire username: ");
  String? username = stdin.readLineSync();
  final RegExp regex = RegExp("[A-Za-z0-9]+");
  if (!regex.hasMatch(username!)) {
    throw Exception("Username non valido");
  }
  if (DBManager.getInstance()!.userNameExisting(username)) {
    throw Exception(
        "username $username gi?? esistente, selezionare un diverso nome utente");
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
    throw Exception("la password inserita non ?? uguale alla precedente");
  }
  int id = await DBManager.getInstance()!.register(username, pass);
  print("[INFO] i dati inseriti sono corretti! L'id del nuovo utente ??: $id");
  return id;
}

Future<void> login() async {
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
  String? name = DBManager.getInstance()?.login(username, pass);
  print("[INFO] login eseguito correttamente");
  logged = true;
  await startGame(name!);
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
