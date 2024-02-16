
import 'package:todo/domain/entity/unique_id.dart';

class ToDoEntry {
  final String description;
  final bool isDown;
  final EntryId id;

  const ToDoEntry({
    required this.description,
    required this.id,
    required this.isDown
  });

  factory ToDoEntry.empty(){
    return ToDoEntry(description: '', id: EntryId(), isDown: false);
  }
}