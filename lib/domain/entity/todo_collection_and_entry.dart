import 'package:todo/domain/entity/todo_entry.dart';
import 'package:todo/domain/entity/unique_id.dart';

class ToDoCollectionAndEntry{
  final CollectionId id;
  final String title;
  final int colorIndex;
  final List<ToDoEntry> entryList;

  ToDoCollectionAndEntry({
    required this.id,
    required this.title,
    required this.colorIndex,
    required this.entryList
  });
}