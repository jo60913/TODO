import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';
@JsonSerializable()
class ApiResponse {
  @JsonKey(name: 'ErrorMsg')
  final String errorMsg;
  @JsonKey(name: 'ErrorFlag')
  final String errorFlag;
  const ApiResponse({required this.errorMsg,required this.errorFlag});

  factory ApiResponse.fromJson(Map<String,dynamic> json) =>_$ApiResponseFromJson(json);
  Map<String,dynamic> toJson() => _$ApiResponseToJson(this);
}