import '../../model/todo_collection_model.dart';
import '../../model/todo_entry_model.dart';

abstract class ToDoRemoteDataSourceInterface {
  Future<ToDoEntryModel> getToDoEntry({
    required String userID,
    required String collectionId,
    required String entryId,
  });

  Future<List<String>> getToDoEntryIds({
    required String userID,
    required String collectionId,
  });

  Future<ToDoCollectionModel> getToDoCollection({
    required String userID,
    required String collectionId,
  });

  Future<List<String>> getToDoCollectionIds({
    required String userID,
  });

  Future<bool> createToDoEntry({
    required String userID,
    required String collectionId,
    required ToDoEntryModel entry,
  });

  Future<bool> createToDoCollection({
    required String userID,
    required ToDoCollectionModel collection,
  });

  Future<ToDoEntryModel> updateToDoEntry({
    required String userID,
    required String collectionId,
    required ToDoEntryModel entry,
  });
}
