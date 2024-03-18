import '../../../domain/entity/todo_collection.dart';
import '../../../domain/entity/todo_color.dart';
import '../../../domain/entity/unique_id.dart';
import '../../model/todo_collection_model.dart';

mixin ToDoCollectionMapper{
  ToDoCollection toDoCollectionModelToEntity(ToDoCollectionModel model) {
    return ToDoCollection(
        id: CollectionId.fromUniqueString(model.id),
        title: model.title,
        color: ToDoColor(
          colorIndex: model.colorIndex,
        ));
  }

  ToDoCollectionModel toDoCollectionToModel(ToDoCollection collection) {
    return ToDoCollectionModel(
      id: collection.id.value,
      colorIndex: collection.color.colorIndex,
      title: collection.title,
    );
  }
}