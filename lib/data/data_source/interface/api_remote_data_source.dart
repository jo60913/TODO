
import 'package:todo/data/model/api/api_response.dart';

abstract class ApiRemoteDataSourceInterface{
  Future<bool> getFCMSetting({
    required String userID,
  });

  Future<ApiResponse> uploadFCMValue({required String userID,required bool fcmValue});
}