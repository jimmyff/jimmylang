import 'dart:convert';

import 'package:jimmylang/jimmyscript.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print(
        '${record.level.name}: ${record.time.millisecond}: ${record.message}');
  });

  test('Simple assign to AST', () {
    final tokens = [
      Token(body: 'double', type: TokenType.type),
      Token(body: 'myDouble', type: TokenType.variable),
      Token(body: '=', type: TokenType.operator),
      Token(body: '3.14159265358', type: TokenType.double),
    ];

    final expectedAst = AstNode(
        token: Token(body: '=', type: TokenType.operator, precedence: 0),
        children: [
          AstNode(
              token: Token(body: 'double', type: TokenType.type, precedence: 0),
              children: [
                AstNode(
                    token: Token(
                        body: 'myDouble',
                        type: TokenType.variable,
                        precedence: 0),
                    children: [])
              ]),
          AstNode(
              token: Token(body: '3.14159265358', type: TokenType.double),
              children: [])
        ]);

    final ast = AstParser.parse(tokens);

    expect(ast.token.type, equals(TokenType.operator));
    expect(ast.children.length, equals(2));
    expect(ast.children[0].token.type, equals(TokenType.type));
    expect(ast.children[0].children.length, equals(1));
    expect(
        json.encode(ast.toJson()), equals(json.encode(expectedAst.toJson())));
  });
}
