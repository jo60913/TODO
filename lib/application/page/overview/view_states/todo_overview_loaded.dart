import 'package:flutter/material.dart';

import '../../../../domain/entity/todo_collection.dart';

class ToDoOverviewLoaded extends StatelessWidget {
  const ToDoOverviewLoaded({super.key, required this.collections});

  final List<ToDoCollection> collections;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final item = collections[index];
          final colorScheme = Theme.of(context).colorScheme;

          return ListTile(
            tileColor: colorScheme.surface,
            selectedTileColor: colorScheme.surfaceVariant,
            iconColor: item.color.color,
            selectedColor: item.color.color,
            onTap: () => debugPrint('點下的標題 : ${item.title}'),
            leading: const Icon(Icons.circle),
            title: Text(item.title),
          );
        });
  }
}
