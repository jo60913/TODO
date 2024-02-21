import 'package:either_dart/either.dart';
import 'package:todo/domain/entity/todo_entry.dart';

import '../../domain/entity/todo_collection.dart';
import '../../domain/entity/todo_color.dart';
import '../../domain/entity/unique_id.dart';
import '../../domain/failure/failures.dart';
import '../../domain/repository/todo_repository.dart';

class ToDoRepositoryMock implements ToDoRepository {
  final List<ToDoEntry> todoEntries = List.generate(
      100,
      (index) => ToDoEntry(
          description: 'description $index',
          id: EntryId.fromUniqueString(index.toString()),
          isDown: false));

  final toDoCollection = List<ToDoCollection>.generate(
    10,
    (index) => ToDoCollection(
      id: CollectionId.fromUniqueString(index.toString()),
      title: 'title $index',
      color: ToDoColor(
        colorIndex: index % ToDoColor.predefinedColors.length,
      ),
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
      final endIndex = startIndex + 10;
      final entryIds = todoEntries.sublist(startIndex, endIndex).map((entry) => entry.id).toList();

      return Future.delayed(
        const Duration(milliseconds: 300),
            () => Right(entryIds),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }
}
