import 'package:jimmylang/jimmyscript.dart';
import 'package:test/test.dart';

void main() {
  test('Simple assign', () {
    String input = '''
double myDouble = 5.4;
''';

    final tokens = Lexer.tokenize(input);
    for (var t in tokens) {
      print(t);
    }

    expect(tokens, isList);
    expect(tokens[0].type, equals(TokenType.type));
    expect(tokens[1].type, equals(TokenType.variable));
    expect(tokens[1].body, equals('myDouble'));
  });
  test('Function', () {
    String input = '''
print "hello world";
''';

    final tokens = Lexer.tokenize(input);
    for (var t in tokens) {
      print(t);
    }
    expect(tokens, isList);
    expect(tokens[0].type, equals(TokenType.function));
    expect(tokens[1].type, equals(TokenType.string));
    expect(tokens[1].body, equals('hello world'));
  });
}
