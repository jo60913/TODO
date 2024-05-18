import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  @JsonKey(name: 'ErrorMsg')
  final String errorMsg;
  @JsonKey(name: 'ErrorFlag')
  final String errorFlag;
  @JsonKey(name: 'Data')
  final bool data;

  const ApiResponse(
      {required this.errorMsg, required this.errorFlag, required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
