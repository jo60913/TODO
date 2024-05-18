import 'package:todo/domain/repository/todo_repository.dart';

class UpdateFCMValue {
  final ToDoRepository toDoRepository;

  const UpdateFCMValue({required this.toDoRepository});

  Future<bool> call(bool fcmValue) async {
    try {
      final result = await toDoRepository.uploadFCMValue(fcmValue);
      if(result.isLeft) {
        return Future.value(!fcmValue);
      }else{
        if(result.right.errorFlag == "0") {
          return Future.value(result.right.data);
        }else{
          return Future.value(!fcmValue);
        }
      }
    } on Exception{
      return !fcmValue;
    }
  }
}
