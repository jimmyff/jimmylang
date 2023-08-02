import 'tokens.dart';

/// Represents a node in our syntax tree
class AstNode {
  final Token token;
  final List<AstNode> children;

  AstNode({
    required this.token,
    required this.children,
  });

  static String _tree(AstNode node, int depth) => '${List.generate(
        depth,
        (index) => ' ',
      ).join('')} AstNode<${node.token.type}> ${node.children.map((e) => _tree(e, depth + 1))}';

  @override
  String toString() => _tree(this, 0);
  // 'AstNode(Token<${token.type}>(${token.body}), [${children.join(', ')}]';
}

// The ordering of nodes in a operator statement
enum OperatorAssociativity {
  left, // evaluated left to right
  right, // evaluated right to left
}

// TODO: We don't currently support any right to left assocatives
OperatorAssociativity getOperatorAssociativity(Token t) =>
    OperatorAssociativity.left;

/// Parse tokens in to an abstract syntax tree (AST)
class AstParser {
  /// Shunting yard algorithm:
  /// https://en.wikipedia.org/wiki/Shunting_yard_algorithm
  /// Adapted for a tree rather than single string
  static AstNode parse(List<Token> tokens) {
    List<Token> operatorStack = [];
    List<AstNode> queue = [];

    for (var t in tokens) {
      // print('Parsing token: $t');
      // print('Queue: $queue');
      switch (t.type) {
        // literals & constants
        case TokenType.int:
        case TokenType.string:
        case TokenType.double:
        case TokenType.string:
        case TokenType.variable:
          queue.add(AstNode(token: t, children: []));
          break;

        case TokenType.function:
        case TokenType.type:
        case TokenType.openParentheses:
          operatorStack.add(t);

        case TokenType.operator:
          while (operatorStack.isNotEmpty) {
            final o = operatorStack.last;
            // print('Iterating over op stack: o: $o');

            if ((o.precedence > t.precedence ||
                    (o.precedence == t.precedence &&
                        getOperatorAssociativity(t) ==
                            OperatorAssociativity.left)) &&
                o.type != TokenType.openParentheses) {
              // remove token from op stack
              operatorStack.removeLast();

              // create branches

              queue = pushToAst(o, queue);
            }
          }

        case TokenType.closeParentheses:
          throw Exception('Not implemented');

        case TokenType.delimiter:
          // ignore for now
          break;
      }
    }

    return queue.last;
  }

  static List<AstNode> pushToAst(Token t, List<AstNode> queue) {
    switch (t.type) {
      case TokenType.operator:
        queue.add(AstNode(
            token: t,

            // If an operator create left right branches
            children: [
              //left
              queue.removeLast(),
              // right
              queue.removeLast()
            ]));
        break;
      case TokenType.function:
        throw Exception('Not implemented yet');
      default:
        queue.add(AstNode(token: t, children: []));
    }
    return queue;
  }
}
