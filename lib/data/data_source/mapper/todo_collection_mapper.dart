import '../../../domain/entity/todo_collection.dart';
import '../../../domain/entity/unique_id.dart';
import '../../model/todo_collection_model.dart';

mixin ToDoCollectionMapper{
  ToDoCollection toDoCollectionModelToEntity(ToDoCollectionModel model) {
    return ToDoCollection(
        id: CollectionId.fromUniqueString(model.id),
        title: model.title,
        itemIndex: model.colorIndex,
        );
  }

  ToDoCollectionModel toDoCollectionToModel(ToDoCollection collection) {
    return ToDoCollectionModel(
      id: collection.id.value,
      colorIndex: collection.itemIndex,
      title: collection.title,
    );
  }
}