// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      precedence: json['precedence'] as int? ?? 0,
      body: json['body'] as String,
      type: $enumDecode(_$TokenTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'precedence': instance.precedence,
      'body': instance.body,
      'type': _$TokenTypeEnumMap[instance.type]!,
    };

const _$TokenTypeEnumMap = {
  TokenType.int: 'int',
  TokenType.double: 'double',
  TokenType.string: 'string',
  TokenType.operator: 'operator',
  TokenType.function: 'function',
  TokenType.delimiter: 'delimiter',
  TokenType.openParentheses: 'openParentheses',
  TokenType.closeParentheses: 'closeParentheses',
  TokenType.type: 'type',
  TokenType.variable: 'variable',
};
