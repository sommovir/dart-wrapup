import 'package:crappy_steam/Game.dart';

class Account {
  final int _id;
  final String _username;
  final String _password;
  int _money = 100;
  List<Game> _games = [];
  Game? playedGame;

  Account(this._id, this._username, this._password);

  int get id => _id;
  String get username => _username;
  String get password => _password;
  int get money => _money;
  List<Game> get games => _games;
  void setPlayedGame(Game game) => playedGame = game;
  //set id(int id) => _id = id;
}
