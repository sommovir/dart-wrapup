import 'package:crappy_steam/Game.dart';

class GameManager {
  static GameManager? _instance; //sperando sia null

  GameManager._() {
    inizializzazione();
  }
  List<Game> _games = [];

  //PATTERN SINGLETON
  static GameManager? getInstance() {
    _instance ??=
        GameManager._(); //if _instance è nullo usa il costruttore priv.
    return _instance;
  }

  void inizializzazione() {
    _games.clear();
    _games.add(Game(20, "Gioco 1", 1, true));
    _games.add(Game(30, "Gioco 2", 2, false));
    _games.add(Game(25, "Gioco 3", 3, true));
    _games.add(Game(40, "Gioco 4", 4, false));
    _games.add(Game(50, "Gioco 5", 5, false));
  }

  List<Game> getGames() => _games;
}
