import 'package:either_dart/either.dart';
import 'package:todo/domain/entity/todo_entry.dart';
import 'package:todo/domain/entity/unique_id.dart';

import '../entity/todo_collection.dart';
import '../failure/failures.dart';

abstract class ToDoRepository {
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections();
  Future<Either<Failure , ToDoEntry>> readToDoEntry(CollectionId collectionId, EntryId entryId);
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(CollectionId collectionId);
  Future<Either<Failure, ToDoEntry>> updateToDoEntry({required CollectionId collectionId,required EntryId entryId,});
  Future<Either<Failure, bool>> createToDoCollection(ToDoCollection collection);
  Future<Either<Failure, bool>> createToDoEntry(ToDoEntry toDoEntry);
}