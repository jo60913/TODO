import 'package:either_dart/either.dart';
import 'package:todo/data/model/api/api_response.dart';
import 'package:todo/domain/entity/todo_entry.dart';
import '../../domain/entity/todo_collection.dart';
import '../../domain/entity/unique_id.dart';
import '../../domain/failure/failures.dart';
import '../../domain/repository/todo_repository.dart';

class ToDoRepositoryMock implements ToDoRepository {
  final List<ToDoEntry> todoEntries = List.generate(
      100,
      (index) => ToDoEntry(
          description: 'description $index',
          id: EntryId.fromUniqueString(index.toString()),
          isDone: false));

  final toDoCollection = List<ToDoCollection>.generate(
    10,
    (index) => ToDoCollection(
      id: CollectionId.fromUniqueString(index.toString()),
      title: 'title $index',
      itemIndex: index,
    ),
  );

  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections() {
    try {
      return Future.delayed(
        const Duration(milliseconds: 200),
        () => Right(toDoCollection),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> readToDoEntry(
      CollectionId collectionId, EntryId entryId) {
    try {
      final selectEntryItem =
          todoEntries.firstWhere((element) => element.id == entryId);

      return Future.delayed(
        const Duration(milliseconds: 200),
        () => Right(selectEntryItem),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(CollectionId collectionId) {
    try {
      final startIndex = int.parse(collectionId.value) * 10;
      int endIndex = startIndex + 10;
      if (todoEntries.length < endIndex) {
        endIndex = todoEntries.length;
      }
      List<EntryId> entryIds = [];

      if(startIndex <= todoEntries.length){
        entryIds = todoEntries.sublist(startIndex, endIndex).map((entry) => entry.id).toList();
      }

      return Future.delayed(
        const Duration(milliseconds: 300),
            () => Right(entryIds),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> updateToDoEntry({required CollectionId collectionId, required ToDoEntry entry}) {
    final index = todoEntries.indexWhere((element) => element.id == entry.id);
    final entryToUpdate = todoEntries[index];
    final updateEntry = todoEntries[index].copyWith(isDone: !entryToUpdate.isDone);
    todoEntries[index] = updateEntry;

    return Future.delayed(const Duration(milliseconds: 100),() => Right(updateEntry));
  }

  @override
  Future<Either<Failure, bool>> createToDoCollection(ToDoCollection collection) {
    final collectionToAdd = ToDoCollection(id: CollectionId.fromUniqueString(toDoCollection.length.toString()), title: collection.title, itemIndex: collection.itemIndex);
    toDoCollection.add(collectionToAdd);
    return Future.delayed(const Duration(milliseconds: 100), () => const Right(true));
  }

  @override
  Future<Either<Failure, bool>> createToDoEntry(_,ToDoEntry entry) {
    todoEntries.add(entry);
    return Future.delayed(const Duration(milliseconds: 250), () => const Right(true));
  }

  @override
  Future<Either<Failure, List<ToDoEntry>>> getAllEntryByCollection(CollectionId collectionId) {
    // TODO: implement getAllEntryByCollection
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteToDoEntry(CollectionId collectionId, ToDoEntry toDoEntry) {
    // TODO: implement deleteToDoEntry
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteToCollection(CollectionId collectionId) {
    // TODO: implement deleteToCollection
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> loadFCMSetting() {
    // TODO: implement loadFCMSetting
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ApiResponse>> uploadFCMValue(bool fcmValue) {
    // TODO: implement uploadFCMValue
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> createFCMToken() {
    // TODO: implement createFCMToken
    throw UnimplementedError();
  }
}
