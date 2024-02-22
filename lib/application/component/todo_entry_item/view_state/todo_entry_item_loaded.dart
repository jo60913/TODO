import 'package:flutter/material.dart';

import '../../../../domain/entity/todo_entry.dart';

class ToDoEntryItemLoaded extends StatelessWidget {
  final ToDoEntry toDoEntry;
  final Function(bool?) onChanged;
  const ToDoEntryItemLoaded({super.key, required this.toDoEntry,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(toDoEntry.description),
      value: toDoEntry.isDone,
      onChanged: onChanged,
    );
  }
}
