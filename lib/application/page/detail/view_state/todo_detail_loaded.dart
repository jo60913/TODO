import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/application/component/todo_entry_item/todo_entry_item.dart';
import 'package:todo/application/page/create_todo_entry/create_todo_entry_page.dart';
import 'package:todo/application/page/detail/bloc/to_do_detail_cubit.dart';
import 'package:todo/domain/entity/unique_id.dart';

import '../../create_todo_collection_page/create_todo_collection_page.dart';


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
          child: Stack(
            children: [
              ListView.builder(
                itemCount: entryIds.length,
                itemBuilder: (context, index) =>
                    ToDoEntryItemProvider(
                      entryId: entryIds[index],
                      collectionId: collectionId,
                    ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  key: const Key('create-todo-entry'),
                  heroTag: 'create-todo-entry',
                  onPressed: () =>
                      context.pushNamed(
                          CreateToDoEntryPage.pageConfig.name,
                          extra: CreateToDoEntryPageExtra(
                              collectionId: collectionId,
                              toDoEntryItemAddedCallback: context.read<ToDoDetailCubit>().fetch)),
                  child: const Icon(Icons.add_rounded),
                ),
              )
            ],
          ),
        ));
  }
}
