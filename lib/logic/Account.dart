import 'package:crappy_steam/Game.dart';

class Account {
  final int _id;
  final String _username;
  final String _password;
  int _money = 100;
  List<Game> _games = [];
  Game? playedGame;

  Account(this._id, this._username, this._password, this._money, this._games);

  int get id => _id;
  String get username => _username;
  String get password => _password;
  int get money => _money;
  List<Game> get games => _games;
  void setPlayedGame(Game game) => playedGame = game;
  //set id(int id) => _id = id;
  void buyGames(int b, Account account, Game game) {
    if (_money - b > 0) {
      _money -= b;
      print("[INFO] GIOCO ACQUISTATO");
      account.games.add(game);
    } else {
      print("[INFO] SALDO NON SUFFICIENTE");
    }
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    List<Game> games = [];
    final id = json['id'] as int;
    final username = json['username'] as String;
    final password = json['password'] as String;
    final money = json['money'] as int;
    if (json['games'] != null) {
      final games = json['games'] as List<Game>;
    }

    return Account(id, username, password, money, games);
  }

  static Map<String, dynamic> toJson(Account value) => {
        'id': value.id,
        'username': value.username,
        'pwd': value.password,
        'money': value.money
      };

  @override
  String toString() {
    return "id: $_id, username: $_username, psswd: $_password, money: $_money";
  }
}
