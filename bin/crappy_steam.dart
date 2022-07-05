import 'package:crappy_steam/Account.dart';
import 'package:crappy_steam/crappy_steam.dart' as crappy_steam;

const String version = "0.1";

void main(List<String> arguments) {
  print("======== Welcome to Crappy Steam =========");
  print("                  v.$version");
  print("==========================================");
  print('Hello world: ${crappy_steam.calculate()}!');

  Account account = Account(3);
  print(account.id);
}
