import 'package:json_annotation/json_annotation.dart';

part 'tokens.g.dart';

enum TokenType {
  int,
  double,
  string,
  operator,
  function,
  delimiter,
  openParentheses, // (
  closeParentheses, // )
  type,
  variable,
}

enum BuiltInFunctions {
  print,
}

/// Represents a single token in a code statement
@JsonSerializable()
class Token {
  /// priority of processing
  final int precedence;

  /// our tokens body
  final String body;

  final TokenType type;

  const Token({this.precedence = 0, required this.body, required this.type});

  @override
  String toString() {
    return '$type($body)';
  }

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
