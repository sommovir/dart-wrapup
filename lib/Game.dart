import 'package:crappy_steam/Purchasable.dart';

class Game implements Purchasable {
  final int _price;
  final String _name;
  final String _id;

  Game(this._price, this._name, this._id);

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
}
