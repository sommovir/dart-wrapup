class NotMuchMoney implements Exception {
  final String message;

  NotMuchMoney(this.message);

  @override
  String toString() => message;
}