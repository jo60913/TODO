import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/data/data_source/interface/todo_remote_data_source_interface.dart';
import 'package:todo/data/data_source/mapper/todo_collection_mapper.dart';
import 'package:todo/data/data_source/mapper/todo_entry_mapper.dart';
import 'package:todo/data/exception/exception.dart';
import 'package:todo/domain/entity/todo_collection.dart';
import 'package:todo/domain/entity/todo_entry.dart';
import 'package:todo/domain/entity/unique_id.dart';
import 'package:todo/domain/failure/failures.dart';
import 'package:todo/domain/repository/todo_repository.dart';

class ToDoRepositoryRemote
    with ToDoCollectionMapper, ToDoEntryMapper
    implements ToDoRepository {
  final ToDoRemoteDataSourceInterface remoteSource;

  String get userID =>
      FirebaseAuth.instance.currentUser?.uid ?? 'some-user-id123';

  ToDoRepositoryRemote({required this.remoteSource});

  @override
  Future<Either<Failure, bool>> createToDoCollection(
      ToDoCollection collection) async {
    try {
      final result = await remoteSource.createToDoCollection(
        userID: userID,
        collection: toDoCollectionToModel(collection),
      );
      return Right(result);
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> createToDoEntry(
      CollectionId collectionId, ToDoEntry toDoEntry) async {
    try {
      final result = await remoteSource.createToDoEntry(
          userID: userID,
          collectionId: collectionId.value,
          entry: toDoEntryToModel(toDoEntry));
      return Right(result);
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections() async {
    try {
      final collectionIds =
          await remoteSource.getToDoCollectionIds(userID: userID);
      final List<ToDoCollection> collections = [];
      for (String collectionId in collectionIds) {
        final collection = await remoteSource.getToDoCollection(
          userID: userID,
          collectionId: collectionId,
        );
        collections.add(toDoCollectionModelToEntity(collection));
      }
      return Right(collections);
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> readToDoEntry(
      CollectionId collectionId, EntryId entryId) async {
    try {
      final result = await remoteSource.getToDoEntry(
        userID: userID,
        collectionId: collectionId.value,
        entryId: entryId.value,
      );
      return Right(toDoEntryModelToEntity(result));
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
      CollectionId collectionId) async {
    try {
      final entries = await remoteSource.getToDoEntryIds(
          userID: userID, collectionId: collectionId.value);
      return Right(entries.map((e) => EntryId.fromUniqueString(e)).toList());
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> updateToDoEntry(
      {required CollectionId collectionId, required ToDoEntry entry}) async {
    try {
      final updateEntry = await remoteSource.updateToDoEntry(
        userID: userID,
        collectionId: collectionId.value,
        entry: toDoEntryToModel(entry),
      );
      return Right(toDoEntryModelToEntity(updateEntry));
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }
}
