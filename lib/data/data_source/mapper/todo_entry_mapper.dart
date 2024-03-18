import '../../../domain/entity/todo_entry.dart';
import '../../../domain/entity/unique_id.dart';
import '../../model/todo_entry_model.dart';

mixin ToDoEntryMapper{
  ToDoEntry toDoEntryModelToEntity(ToDoEntryModel model) {
    return ToDoEntry(
        id: EntryId.fromUniqueString(model.id),
        description: model.description,
        isDone: model.isDone);
  }

  ToDoEntryModel toDoEntryToModel(ToDoEntry entry) {
    return ToDoEntryModel(
        id: entry.id.value, description: entry.description, isDone: entry.isDone);
  }
}