
abstract class ApiRemoteDataSourceInterface{
  Future<bool> getFCMSetting({
    required String userID,
  });
}