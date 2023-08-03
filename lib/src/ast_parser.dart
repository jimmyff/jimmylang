import 'dart:convert';

import 'tokens.dart';

import 'package:logging/logging.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ast_parser.g.dart';

/// Represents a node in our syntax tree
@JsonSerializable()
class AstNode {
  final Token token;
  final List<AstNode> children;

  AstNode({
    required this.token,
    required this.children,
  });

  // static String _tree(AstNode node, int depth) => '${List.generate(
  //       depth,
  //       (index) => ' ',
  //     ).join('')} AstNode<${node.token.type}>[\n${node.children.map((e) => _tree(e, depth + 1)).join('\n')}]';

  @override
  String toString() => JsonEncoder.withIndent("     ").convert(toJson());

  factory AstNode.fromJson(Map<String, dynamic> json) =>
      _$AstNodeFromJson(json);
  Map<String, dynamic> toJson() => _$AstNodeToJson(this);
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
    final _log = Logger('AstParser');

    List<Token> operatorStack = [];
    List<AstNode> queue = [];
    List<int> args = [];

    for (var t in tokens) {
      _log.fine('Parsing token: $t (queue length: ${queue.length})');
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
          args.add(-1);
          operatorStack.add(t);

          break;
        case TokenType.openParentheses:
          operatorStack.add(t);
          break;
        case TokenType.operator:
          while (operatorStack.isNotEmpty) {
            final o = operatorStack.last;
            _log.fine('Iterating over op stack: o: ${o.type} ${o.body}');

            if ((o.precedence > t.precedence ||
                    (o.precedence == t.precedence &&
                        getOperatorAssociativity(t) ==
                            OperatorAssociativity.left)) &&
                o.type != TokenType.openParentheses) {
              // remove token from op stack
              operatorStack.removeLast();

              // create branches

              queue = pushToAst(t: o, queue: queue, args: args, log: _log);
            }
          }
          operatorStack.add(t);
          break;

        case TokenType.closeParentheses:
          throw Exception('Not implemented');

        case TokenType.delimiter:
          // ignore for now
          break;
      }

      if (args.isNotEmpty) args.last++;
    }

    for (var o in operatorStack) {
      pushToAst(t: o, queue: queue, args: args, log: _log);
    }

    return queue.last;
  }

  static List<AstNode> pushToAst(
      {required Token t,
      required List<AstNode> queue,
      required List<int> args,
      Logger? log}) {
    log?.fine('Pushing ${t.type} to AST. queue=$queue args=$args');
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
            ].reversed.toList()));
        break;
      case TokenType.type:
      case TokenType.function:
        final children = List<AstNode>.generate(
            args.removeLast(), (index) => queue.removeLast());
        queue.add(AstNode(token: t, children: children));

        break;
      default:
        queue.add(AstNode(token: t, children: []));
    }
    return queue;
  }
}
