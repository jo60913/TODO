import 'package:either_dart/either.dart';
import '../../core/use_case.dart';
import '../failure/failures.dart';
import '../repository/todo_repository.dart';

class DeleteToDoCollection implements UseCase<bool, CollectionIdsParam> {
  final ToDoRepository toDoRepository;

  DeleteToDoCollection({required this.toDoRepository});

  @override
  Future<Either<Failure, bool>> call(CollectionIdsParam params) async {
    try {
      final result = await toDoRepository.deleteToCollection(params.collectionId,);

      return result.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
