import 'package:jimmylang/jimmyscript.dart';

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
  final tokens = Lexer.tokenize(input);
  final parsed = AstParser.parse(tokens);

  print(parsed);
}
