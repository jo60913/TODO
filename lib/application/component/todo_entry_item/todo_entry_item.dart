import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/component/todo_entry_item/view_state/todo_entry_item_error.dart';
import 'package:todo/application/component/todo_entry_item/view_state/todo_entry_item_loading.dart';
import 'package:todo/domain/entity/unique_id.dart';
import 'package:todo/domain/repository/todo_repository.dart';
import 'package:todo/domain/usecase/load_todo_entry.dart';
import 'package:todo/domain/usecase/update_todo_entry.dart';

import 'bloc/todo_entry_item_cubit.dart';
import 'view_state/todo_entry_item_loaded.dart';

class ToDoEntryItemProvider extends StatelessWidget {
  final EntryId entryId;
  final CollectionId collectionId;

  const ToDoEntryItemProvider(
      {super.key, required this.entryId, required this.collectionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoEntryItemCubit>(
      create: (context) => TodoEntryItemCubit(
        entryId: entryId,
        collectionId: collectionId,
        loadToDoEntry: LoadToDoEntry(
            toDoRepository: RepositoryProvider.of<ToDoRepository>(context)),
        uploadToDoEntry: UpdateToDoEntry(toDoRepository: RepositoryProvider.of<ToDoRepository>(context))
      )..fetch(),
      child: const ToDoEntryItem(),
    );
  }
}

class ToDoEntryItem extends StatelessWidget {
  const ToDoEntryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEntryItemCubit, TodoEntryItemState>(
        builder: (context, state) {
      if (state is TodoEntryItemLoadingState) {
        return const ToDoEntryItemLoading();
      } else if (state is TodoEntryItemLoadedState) {
        return ToDoEntryItemLoaded(
            toDoEntry: state.toDoEntry,
            onChanged: (value) => context.read<TodoEntryItemCubit>().update());
      } else {
        return const ToDoEntryItemError();
      }
    });
  }
}
