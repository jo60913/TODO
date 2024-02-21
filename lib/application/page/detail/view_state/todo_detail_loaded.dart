import 'package:flutter/material.dart';
import 'package:todo/domain/entity/unique_id.dart';

class ToDoDetailLoaded extends StatelessWidget {
  final List<EntryId> entryIds;
  final CollectionId collectionId;

  const ToDoDetailLoaded(
      {super.key, required this.collectionId, required this.entryIds});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: entryIds.length,
        itemBuilder: (context, index) => const Text('index'),
      ),
    ));
  }
}
