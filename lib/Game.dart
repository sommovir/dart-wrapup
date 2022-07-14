import 'package:crappy_steam/Purchasable.dart';

class Game implements Purchasable {
  final int _price;
  final String _name;
  final String _id;
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

  String getId() {
    return _id;
  }

  bool get multiplayer => _multiplayer;

  /*factory Game.fromJson(List<dynamic> json) {
    for(dynamic item in json){
    final _id = json['id'] as int;
    final _name = json['name'];
    final _price = int.parse(['price']);
    final _multiplayer = json['multiplayer'] as bool;
    }
    }

    return Game(price,name,id,multiplayer);
  }*/
}
