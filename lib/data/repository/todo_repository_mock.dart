import 'package:either_dart/either.dart';

import '../../domain/entity/todo_collection.dart';
import '../../domain/entity/todo_color.dart';
import '../../domain/entity/unique_id.dart';
import '../../domain/failure/failures.dart';
import '../../domain/repository/todo_repository.dart';

class ToDoRepositoryMock implements ToDoRepository {
  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections() {
    final list = List<ToDoCollection>.generate(
      10,
          (index) => ToDoCollection(
        id: CollectionId.fromUniqueString(index.toString()),
        title: 'title $index',
        color: ToDoColor(
          colorIndex: index % ToDoColor.predefinedColors.length,
        ),
      ),
    );

    return Future.delayed(
      const Duration(milliseconds: 200),
          () => Right(list),
    );
  }
}