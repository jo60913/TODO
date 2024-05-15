import 'package:dio/dio.dart';
import 'package:todo/data/model/api/get_token_response.dart';
import '../interface/api_remote_data_source.dart';

class ApiRemoteDataSource implements ApiRemoteDataSourceInterface{
  @override
  Future<bool> getFCMSetting({required String userID}) async {
    var dio = Dio();
    var response = await dio.post("https://todo-api-silk.vercel.app/get/notification",data:{"UserToken":userID});
    var data = GetTokenResponse.fromJson(response.data);
    return Future.value(data.data);
  }

}