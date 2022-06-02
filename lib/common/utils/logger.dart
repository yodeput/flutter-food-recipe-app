class Logger {
  static void sys(String text, {bool isError = false}) {
    if (!isError)
      Future.microtask(() => print('\x1B[33m ** $text \x1B[0m'));
    else
      Future.microtask(() => print('\x1B[31m ** ERROR ** $text \x1B[0m'));
  }

  static void write({required String? runtimeType, required String? method, required String? message, Function color = success}) {
    color("[$runtimeType $method] => $message");
  }

  static void warning(String text) {
    print('\x1B[33m┌─────────────────────────────────────────\x1B[0m');
    print('\x1B[33m|    $text\x1B[0m');
    print('\x1B[33m└─────────────────────────────────────────\x1B[0m');
  }

  static void error(String text) {
    print('\x1B[31m┌─────────────────────────────────────────\x1B[0m');
    print('\x1B[31m|    $text\x1B[0m');
    print('\x1B[31m└─────────────────────────────────────────\x1B[0m');
  }

  static void success(String text) {
    print('\x1B[32m┌─────────────────────────────────────────\x1B[0m');
    print('\x1B[32m|    $text\x1B[0m');
    print('\x1B[32m└─────────────────────────────────────────\x1B[0m');
  }
}
