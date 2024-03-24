import 'package:either_dart/either.dart';
import 'package:todo/core/use_case.dart';
import 'package:todo/domain/entity/todo_collection_and_entry.dart';
import 'package:todo/domain/failure/failures.dart';
import '../repository/todo_repository.dart';

class LoadToDoCollectionAndEntry implements UseCase<List<ToDoCollectionAndEntry>,NoParams>{
  final ToDoRepository toDoRepository;
  const LoadToDoCollectionAndEntry({required this.toDoRepository});
  
  @override
  Future<Either<Failure, List<ToDoCollectionAndEntry>>> call(NoParams params) async {
    try{
      final loadedCollections = await toDoRepository.readToDoCollections();
      if(loadedCollections.isLeft){
        return Left(loadedCollections.left);
      }

      final list = loadedCollections.right;
      List<ToDoCollectionAndEntry> collectionList = [];
      for(final item in list){
        final loadedEntries = await toDoRepository.getAllEntryByCollection(item.id);
        if(loadedEntries.isLeft){
          continue;
        }
        final todoCollectionAndEntry = ToDoCollectionAndEntry(id: item.id, title: item.title, color: item.color, entryList:loadedEntries.right);
        collectionList.add(todoCollectionAndEntry);
      }

      return Right(collectionList);
    }on Exception catch(e){
      return Left(ServerFailure(stackTrace : e.toString()));
    }
    
  }
  
}