import 'package:either_dart/either.dart';
import 'package:todo/core/use_case.dart';
import 'package:todo/domain/entity/todo_entry.dart';
import 'package:todo/domain/failure/failures.dart';
import 'package:todo/domain/repository/todo_repository.dart';

class UpdateToDoEntry implements UseCase<ToDoEntry, ToDoEntryParams> {
  final ToDoRepository toDoRepository;

  const UpdateToDoEntry({required this.toDoRepository});

  @override
  Future<Either<Failure, ToDoEntry>> call(ToDoEntryParams params) async {
    try {
      final loadedEntry = await toDoRepository.updateToDoEntry(
        collectionId: params.collectionId,
        entry: params.entry,
      );

      return loadedEntry.fold(
              (left) => Left(left),
              (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
