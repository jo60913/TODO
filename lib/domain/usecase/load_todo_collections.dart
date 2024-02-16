import 'package:either_dart/either.dart';

import '../../core/use_case.dart';
import '../entity/todo_collection.dart';
import '../failure/failures.dart';
import '../repository/todo_repository.dart';

class LoadToDoCollections implements UseCase<List<ToDoCollection>, NoParams> {
  const LoadToDoCollections({required this.toDoRepository});

  final ToDoRepository toDoRepository;

  @override
  Future<Either<Failure, List<ToDoCollection>>> call(NoParams params) async {
    try {
      final loadedCollections = toDoRepository.readToDoCollections();

      return loadedCollections.fold(
            (left) => Left(left),
            (right) => Right(right),
      );
    } on Exception catch (e) {
      return Left(
        ServerFailure(stackTrace: e.toString()),
      );
    }
  }
}