// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTokenResponse _$GetTokenResponseFromJson(Map<String, dynamic> json) =>
    GetTokenResponse(
      errorMsg: json['ErrorMsg'] as String,
      errorFlag: json['ErrorFlag'] as String,
      data: json['Data'] as bool,
    );

Map<String, dynamic> _$GetTokenResponseToJson(GetTokenResponse instance) =>
    <String, dynamic>{
      'ErrorMsg': instance.errorMsg,
      'ErrorFlag': instance.errorFlag,
      'Data': instance.data,
    };
