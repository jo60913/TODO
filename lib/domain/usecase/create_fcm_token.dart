import '../repository/todo_repository.dart';

class CreateFCMToken{
  final ToDoRepository toDoRepository;

  const CreateFCMToken({required this.toDoRepository});

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