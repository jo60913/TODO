import 'package:either_dart/either.dart';
import 'package:todo/core/use_case.dart';
import 'package:todo/domain/failure/failures.dart';
import '../repository/todo_repository.dart';

class DeleteToDoEntry implements UseCase<bool, ToDoEntryParams> {
  final ToDoRepository toDoRepository;

  DeleteToDoEntry({required this.toDoRepository});

  @override
  Future<Either<Failure, bool>> call(ToDoEntryParams params) async {
    try {
      final result = toDoRepository.deleteToDoEntry(
        params.collectionId,
        params.entry,
      );

      return result.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
