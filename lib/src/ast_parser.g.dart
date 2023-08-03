// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ast_parser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AstNode _$AstNodeFromJson(Map<String, dynamic> json) => AstNode(
      token: Token.fromJson(json['token'] as Map<String, dynamic>),
      children: (json['children'] as List<dynamic>)
          .map((e) => AstNode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AstNodeToJson(AstNode instance) => <String, dynamic>{
      'token': instance.token,
      'children': instance.children,
    };
