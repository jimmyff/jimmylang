import 'dart:convert';

import 'package:jimmylang/jimmyscript.dart';
import 'package:logging/logging.dart';

String input = '''
double myDouble = 3.14159265358;
''';

/*
print counter;
counter = ( counter * 2 ) + 10;
*/
void main(List<String> arguments) {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  final tokens = Lexer.tokenize(input);
  print('Tokens');
  print(JsonEncoder.withIndent("     ")
      .convert(tokens.map((e) => e.toJson()).toList()));
  final parsed = AstParser.parse(tokens);

  print('AST');
  print(parsed.toString());
}
