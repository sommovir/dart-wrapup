enum ConsoleColors {
  BLACK("\x1B[30m"),
  RED("\x1B[31m"),
  GREEN("\x1B[32m"),
  YELLOW("\x1B[33m"),
  BLUE("\x1B[34m"),
  MAGENTA("\x1B[35m"),
  CYAN("\x1B[36m"),
  WHITE("\x1B[37m"),
  RESET("\x1B[0m");

  const ConsoleColors(this.code);
  final String code;
}
