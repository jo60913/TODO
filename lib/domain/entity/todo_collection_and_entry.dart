import 'package:todo/domain/entity/todo_color.dart';
import 'package:todo/domain/entity/todo_entry.dart';
import 'package:todo/domain/entity/unique_id.dart';

class ToDoCollectionAndEntry{
  final CollectionId id;
  final String title;
  final ToDoColor color;
  final List<ToDoEntry> entryList;

  ToDoCollectionAndEntry({
    required this.id,
    required this.title,
    required this.color,
    required this.entryList
  });
}