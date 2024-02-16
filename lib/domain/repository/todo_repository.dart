import 'package:either_dart/either.dart';

import '../entity/todo_collection.dart';
import '../failure/failures.dart';

abstract class ToDoRepository {
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections();
}