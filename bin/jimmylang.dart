import 'package:jimmylang/jimmylang.dart';

String input = '''
double myDouble = 5.4;
string myString = "Hayyyy, how are you?";
int counter = 0;
counter = counter + 10;
print counter;
''';

void main(List<String> arguments) {
  final tokens = Lexer.tokenize(input);
  for (var t in tokens) {
    print(t);
  }
}
