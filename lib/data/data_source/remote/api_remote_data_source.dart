import 'package:dio/dio.dart';
import 'package:todo/data/model/api/api_response.dart';
import 'package:todo/data/model/api/get_token_response.dart';
import '../interface/api_remote_data_source.dart';

class ApiRemoteDataSource implements ApiRemoteDataSourceInterface{
  @override
  Future<bool> getFCMSetting({required String userID}) async {
    var dio = Dio();
    var response = await dio.post("https://todo-api-silk.vercel.app/get/notification",data:{"UserID":userID});
    var data = GetTokenResponse.fromJson(response.data);
    return Future.value(data.data);
  }

  @override
  Future<ApiResponse> uploadFCMValue({required String userID,required bool fcmValue}) async {
    var dio = Dio();
    var response = await dio.post("https://todo-api-silk.vercel.app/update/notification",data:{"UserID":userID,"NotificationValue":fcmValue});
    var apiResponse = ApiResponse.fromJson(response.data);
    return Future.value(apiResponse);
  }

  @override
  Future<bool> createFCMToken({required String userID, required String userToken}) async {
    var dio = Dio();
    var response = await dio.post("https://todo-api-silk.vercel.app/update/firstlogin",data:{"UserID":userID,"UserToken":userToken});
    var data = GetTokenResponse.fromJson(response.data);
    return Future.value(data.errorFlag == "0");
  }

}