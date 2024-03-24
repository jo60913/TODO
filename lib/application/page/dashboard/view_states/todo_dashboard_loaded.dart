import 'package:flutter/material.dart';
import 'package:todo/domain/entity/todo_collection_and_entry.dart';

class ToDoDashBoardLoadedPage extends StatelessWidget {
  final List<ToDoCollectionAndEntry> collections;
  const ToDoDashBoardLoadedPage({super.key,required this.collections});

  @override
  Widget build(BuildContext context) {
    for(final item in collections){
      debugPrint('collection ${item.title}');
      final it = item.entryList;
      for(final its in it){
        debugPrint('item ${its.description}');
      }
    }
    return const Placeholder();
  }
}
