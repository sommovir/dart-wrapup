import 'package:crappy_steam/Purchasable.dart';

class Game implements Purchasable {
  final int _price;
  final String _name;
  final int _id;
  final bool _multiplayer;

  Game(this._price, this._name, this._id, this._multiplayer);

  @override
  int getPrice() {
    // TODO: implement getPrice
    return _price;
  }

  String getName() {
    return _name;
  }

  int getId() {
    return _id;
  }

  bool get multiplayer => _multiplayer;

  factory Game.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final name = json['name'];
    final price = json['price'] as int;
    final multiplayer = json['multiplayer'] as bool;
    return Game(price,name,id,multiplayer);

    }

  @override
  String toString() {
    return 'Game{_price: $_price, _name: $_name, _id: $_id, _multiplayer: $_multiplayer}';
  }
}
