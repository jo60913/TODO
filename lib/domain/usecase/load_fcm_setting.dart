import 'package:todo/domain/repository/todo_repository.dart';

class LoadFCMSetting{
  final ToDoRepository toDoRepository;

  const LoadFCMSetting({required this.toDoRepository});

  Future<bool> call() async {
    try {
      final result = await toDoRepository.loadFCMSetting();
      if(result.isLeft) {
        return Future.value(false);
      }else{
        return Future.value(result.right);
      }
  }on Exception{
    return Future.value(false);
    }
  }
}