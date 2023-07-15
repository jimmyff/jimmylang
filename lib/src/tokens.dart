enum TokenType {
  int,
  double,
  string,
  operator,
  function,
  delimiter,
  type,
  variable,
}

class Token {
  /// priority of processing
  final int precedence;

  /// our tokens body
  final String body;

  final TokenType type;

  const Token({this.precedence = 0, required this.body, required this.type});

  @override
  String toString() {
    return '${type.name.padRight(16)}${precedence.toString().padRight(4)}$body';
  }
}
