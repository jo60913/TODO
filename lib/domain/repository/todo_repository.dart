import 'package:either_dart/either.dart';
import 'package:todo/data/model/api/api_response.dart';
import 'package:todo/domain/entity/todo_entry.dart';
import 'package:todo/domain/entity/unique_id.dart';
import '../entity/todo_collection.dart';
import '../failure/failures.dart';

abstract class ToDoRepository {
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections();
  Future<Either<Failure , ToDoEntry>> readToDoEntry(CollectionId collectionId, EntryId entryId);
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(CollectionId collectionId);
  Future<Either<Failure, ToDoEntry>> updateToDoEntry({required CollectionId collectionId,required ToDoEntry entry,});
  Future<Either<Failure, bool>> createToDoCollection(ToDoCollection collection);
  Future<Either<Failure, bool>> createToDoEntry(CollectionId collectionId,ToDoEntry toDoEntry);
  Future<Either<Failure, List<ToDoEntry>>> getAllEntryByCollection(CollectionId collectionId);
  Future<Either<Failure, bool>> deleteToDoEntry(CollectionId collectionId,ToDoEntry toDoEntry);
  Future<Either<Failure, bool>> deleteToCollection(CollectionId collectionId);
  Future<Either<Failure, bool>> loadFCMSetting();
  Future<Either<Failure, ApiResponse>> uploadFCMValue(bool fcmValue);
  Future<Either<Failure, bool>> createFCMToken();
}