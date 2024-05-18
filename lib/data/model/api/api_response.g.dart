// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      errorMsg: json['ErrorMsg'] as String,
      errorFlag: json['ErrorFlag'] as String,
      data: json['Data'] as bool,
    );

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'ErrorMsg': instance.errorMsg,
      'ErrorFlag': instance.errorFlag,
      'Data': instance.data,
    };
