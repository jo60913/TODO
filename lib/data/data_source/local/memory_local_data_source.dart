import 'package:todo/data/data_source/interface/todo_local_data_source_interface.dart';
import 'package:todo/data/model/todo_collection_model.dart';
import 'package:todo/data/model/todo_entry_model.dart';

import '../../exception/exception.dart';

class MemoryLocalDataSource implements ToDoLocalDataSourceInterface {
  final List<ToDoCollectionModel> todoCollection = [];
  final Map<String, List<ToDoEntryModel>> todoEntries = {};

  @override
  Future<bool> createToDoCollection({required ToDoCollectionModel collection}) {
    try {
      todoCollection.add(collection);
      todoEntries.putIfAbsent(collection.id, () => []);
      return Future.value(true);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<bool> createToDoEntry(
      {required collectionId, required ToDoEntryModel entry}) {
    try {
      final doseCollectionExists = todoEntries.containsKey(collectionId);
      if (doseCollectionExists) {
        todoEntries[collectionId]?.add(entry);
        return Future.value(true);
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<ToDoCollectionModel> getToDoCollection(
      {required String collectionId}) {
    try {
      final collectionModel = todoCollection.firstWhere(
          (element) => element.id == collectionId,
          orElse: () => throw CollectionNotFoundException());
      return Future.value(collectionModel);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> getToDoCollectionIds() {
    try {
      return Future.value(
          todoCollection.map((collection) => collection.id).toList());
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<ToDoEntryModel> getToDoEntry(
      {required String collectionId, required String entryId}) {
    try {
      if (todoEntries.containsKey(collectionId)) {
        final entry = todoEntries[collectionId]?.firstWhere(
            (element) => element.id == entryId,
            orElse: () => throw EntryNotFoundException());
        return Future.value(entry);
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> getToDoEntryIds({required String collectionId}) {
    try {
      if (todoEntries.containsKey(collectionId)) {
        return Future.value(
            todoEntries[collectionId]?.map((entry) => entry.id).toList());
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<ToDoEntryModel> updateToDoEntry(
      {required String collectionId, required String entryId}) {
    try {
      if (todoEntries.containsKey(collectionId)) {
        final indexOfElement = todoEntries[collectionId]
            ?.indexWhere((element) => element.id == entryId);
        if (indexOfElement == -1 || indexOfElement == null) {
          throw EntryNotFoundException();
        }
        final entry = todoEntries[collectionId]?[indexOfElement];
        if (entry == null) {
          throw EntryNotFoundException();
        }
        final updateEntry = ToDoEntryModel(
            id: entry.id,
            description: entry.description,
            isDone: !entry.isDone);
        todoEntries[collectionId]?[indexOfElement] = updateEntry;
        return Future.value(updateEntry);
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }
}
