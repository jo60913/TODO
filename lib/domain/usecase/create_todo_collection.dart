import 'package:either_dart/either.dart';
import 'package:todo/domain/failure/failures.dart';
import 'package:todo/domain/repository/todo_repository.dart';

import '../../core/use_case.dart';

class CreateToDoCollection implements UseCase<bool, ToDoCollectionParams> {
  final ToDoRepository toDoRepository;

  const CreateToDoCollection({required this.toDoRepository});

  @override
  Future<Either<Failure, bool>> call(params) async {
    try {
      final result = toDoRepository.createToDoCollection(params.collection);

      return result.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch(e){
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }

}