import 'package:logging/logging.dart';

import 'tokens.dart';

/// Creates tokens from source code
class Lexer {
  static List<Token> tokenize(String input) {
    var buffer = '';
    var tokens = <Token>[];
    final _log = Logger('Lexer');

    for (var character in input.split('')) {
      _log.fine('character=$character buffer=$buffer');

      //
      final isInString = RegExp(r'^"(.*)$').hasMatch(buffer);
      final isString = RegExp(r'^"(.*)"$').hasMatch(buffer);

      if ((!isInString && [' ', '\n', ';'].contains(character)) || isString) {
        // skip double whitespace
        if (buffer.isEmpty && RegExp(r'\s').hasMatch(character)) continue;

        late int precedence;

        // calculate precedence
        switch (buffer) {
          case 'int':
          case 'string':
          case 'double':
            precedence = 3;
            break;
          case '/':
          case '*':
            precedence = 2;
            break;
          case '+':
            precedence = 1;
            break;
          default:
            precedence = 0;
        }

        // convert buffer in to token
        switch (buffer) {
          case 'int':
          case 'string':
          case 'double':
            tokens.add(Token(
                type: TokenType.type, body: buffer, precedence: precedence));
            break;
          case '=':
          case '+':
            tokens.add(Token(
                type: TokenType.operator,
                body: buffer,
                precedence: precedence));
            break;
          case ';':
            tokens.add(Token(
                type: TokenType.delimiter,
                body: buffer,
                precedence: precedence));
            break;
          case '(':
            tokens.add(Token(
                type: TokenType.openParentheses,
                body: buffer,
                precedence: precedence));
            break;
          case ')':
            tokens.add(Token(
                type: TokenType.closeParentheses,
                body: buffer,
                precedence: precedence));
            break;

          default:

            // check if function
            if (BuiltInFunctions.values.map((e) => e.name).contains(buffer)) {
              tokens.add(Token(
                  type: TokenType.function,
                  body: buffer,
                  precedence: precedence));
            } else
            // check if int
            if (RegExp(r'^[0-9]*$').hasMatch(buffer)) {
              tokens.add(Token(
                  type: TokenType.int, body: buffer, precedence: precedence));

              // check if double
            } else if (RegExp(r'^[0-9\.]*$').hasMatch(buffer)) {
              tokens.add(Token(
                  type: TokenType.double,
                  body: buffer,
                  precedence: precedence));

              // check if string
            } else if (RegExp(r'^"(.*)"$').hasMatch(buffer)) {
              tokens.add(Token(
                  type: TokenType.string,
                  body: buffer.substring(1, buffer.length - 1),
                  precedence: precedence));

              // default assume variable name
            } else {
              tokens.add(Token(
                  type: TokenType.variable,
                  body: buffer,
                  precedence: precedence));
            }
        }
        buffer = '';
      } else if (!isInString && [';'].contains(character)) {
        // if (buffer.isNotEmpty)

        tokens.add(
            Token(type: TokenType.delimiter, body: character, precedence: 0));
        buffer = '';
      } else {
        buffer += character;
      }
    }
    return tokens;
  }
}
