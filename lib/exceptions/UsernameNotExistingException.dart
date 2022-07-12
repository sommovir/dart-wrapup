class UsernameNotExistingException implements Exception {
  final String message;

  UsernameNotExistingException(this.message);

  @override
  String toString() => message;
}
