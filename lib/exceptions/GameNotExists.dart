class GameNotExists implements Exception {
  final String message;

  GameNotExists(this.message);

  @override
  String toString() => message;
}
