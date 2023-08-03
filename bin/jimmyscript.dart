import 'package:jimmylang/jimmyscript.dart';
import 'package:logging/logging.dart';

String input = '''
double myDouble = 5.4;
string myString = "Hayyyy, how are you?";
int counter = 0;

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
  final parsed = AstParser.parse(tokens);

  print(parsed.toJson());
}
