import 'package:either_dart/either.dart';
import 'package:todo/core/use_case.dart';
import 'package:todo/domain/entity/unique_id.dart';
import 'package:todo/domain/failure/failures.dart';
import 'package:todo/domain/repository/todo_repository.dart';

class LoadToDoEntryIdsForCollection implements UseCase<List<EntryId>,CollectionIdsParam>{
  final ToDoRepository toDoRepository;
  const LoadToDoEntryIdsForCollection({required this.toDoRepository});

  @override
  Future<Either<Failure, List<EntryId>>> call(CollectionIdsParam params) async{
    try{
      final loadedIds = toDoRepository.readToDoEntryIds(params.collectionId);
      return loadedIds.fold(
              (left)=>Left(left),
              (right)=>Right(right)
      );
    } on Exception catch(e){
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }

}