
import 'package:crappy_steam/exceptions/UsernameExistingException.dart';
import 'package:crappy_steam/logic/Account.dart';
import 'package:crappy_steam/logic/DBManager.dart';
import 'package:test/test.dart';

void main() {
  test('check register not existing username', () {
    /*
    DBManager.getInstance()!.register("gino", "Aisiwi292729");
    Account? a = DBManager.getInstance()!.getAccountByUsername("gino");
    assert(a != null, "L'account non può essere null");
    expect(a!.username, "gino");

     */
  });

  test('check duplicate', () {
    /*
    bool errore = false;
    try {
      DBManager.getInstance()!.register("gino", "Aisiwi292729");
    } on UsernameExistingException catch (e) {
      errore = true;
    }
    expect(errore, true);+
    */
  });
}
