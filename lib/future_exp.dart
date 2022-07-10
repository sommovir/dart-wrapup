import 'dart:collection';

import 'ConsoleColors.dart';

bool connected = false;
void main() async {
  print("ciao");

/*
  var a = connect();
  var b = log();

  print("CIAO HO appena chiamato le due funzioni");
  print("RISULTATO DEL LOG:       ${await b}"); //2  questa chiamata è totalmente bloccante, la riga dopo non sarà eseguita finché
                                                     il valore di b non è terminato
  print("RISULTATO DELLA CONNECT: ${await a}"); //3

  print("FINE FUNZIONE"); //1
  */

  connect().then((value) {
    print("Connect finita");
    queryDB().then((value) => print(value));
  });
  log().then((value) {
    print(value);
    analyze().then((value) => print("il void me lo do in faccia"));
  }); //CALLBACK
}

Future<bool> connect() async {
  print("connecting.. ");
  connected = true;
  return Future.delayed(
    Duration(seconds: 2),
    () => true,
  );
}

Future<String> log() async {
  print("logging.. ");
  return Future.delayed(
    Duration(seconds: 5),
    () => "Log Completato${ConsoleColors.GREEN.code} SUCCESS ${ConsoleColors.RESET.code}",
  );
}

Future<void> analyze() async {
  print("sto analizzando");
  return Future.delayed(Duration(seconds: 2));
}

Future<List<String>> queryDB() async {
  print("querying.. ");
  if (!connected) {
    throw UnsupportedError("non funziona una minchia");
  }
  return Future.delayed(
    Duration(seconds: 1),
    () => ["Gino", "Alfonso", "Caloggero"],
  );
}
