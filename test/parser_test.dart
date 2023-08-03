import 'package:jimmylang/jimmyscript.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print(
        '${record.level.name}: ${record.time.millisecond}: ${record.message}');
  });

  test('Simple assign', () {
    final tokens = [
      Token(body: 'double', type: TokenType.type),
      Token(body: 'myDouble', type: TokenType.variable),
      Token(body: '=', type: TokenType.operator),
      Token(body: '3.14159265358', type: TokenType.double),
    ];

    final ast = AstParser.parse(tokens);
    print('# Result');
    print(ast);

    expect(tokens, isList);

    expect(tokens[0].type, equals(TokenType.type));
    expect(tokens[1].type, equals(TokenType.variable));
    expect(tokens[1].body, equals('myDouble'));
  });
}
