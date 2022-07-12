import 'package:crappy_steam/logic/Account.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test("[Account][testing getter id]", () {
    expect(Account(33).id, 33);
  });
}
