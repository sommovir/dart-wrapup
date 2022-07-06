import 'package:crappy_steam/Purchasable.dart';

class Game implements Purchasable {
  final int _price;

  Game(this._price);

  @override
  int getPrice() {
    // TODO: implement getPrice
    return _price;
  }
}
