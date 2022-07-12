class PsswdWrong implements Exception {
  final String message;

  PsswdWrong(this.message);

  @override
  String toString() => message;
}
