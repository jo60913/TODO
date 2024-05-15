import 'package:either_dart/either.dart';
import 'package:todo/core/use_case.dart';
import 'package:todo/domain/failure/failures.dart';
import 'package:todo/domain/repository/todo_repository.dart';

class LoadFCMSetting implements UseCase<bool, String> {
  final ToDoRepository toDoRepository;

  const LoadFCMSetting({required this.toDoRepository});

  @override
  Future<Either<Failure, bool>> call(String params) async {
    try {
      final result = toDoRepository.loadFCMSetting(params);
      return result.fold((left) => Left(left), (right) => Right(right));
  }on Exception catch(e){
    return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}