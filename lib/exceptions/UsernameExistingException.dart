class UsernameExistingException implements Exception {
  final String message;

  UsernameExistingException(this.message);

  @override
  String toString() => message;
}
