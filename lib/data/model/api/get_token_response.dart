import 'package:json_annotation/json_annotation.dart';

part 'get_token_response.g.dart';
@JsonSerializable()
class GetTokenResponse{
  @JsonKey(name: 'ErrorMsg')
  final String errorMsg;
  @JsonKey(name: 'ErrorFlag')
  final String errorFlag;
  @JsonKey(name: 'Data')
  final bool data;

  const GetTokenResponse({required this.errorMsg,required this.errorFlag,required this.data});

  factory GetTokenResponse.fromJson(Map<String,dynamic> json) =>_$GetTokenResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GetTokenResponseToJson(this);
}