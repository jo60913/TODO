import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/component/todo_entry_item/view_state/todo_entry_item_error.dart';
import 'package:todo/application/component/todo_entry_item/view_state/todo_entry_item_loading.dart';
import 'package:todo/domain/entity/todo_entry.dart';
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
        return GestureDetector(
          child: ToDoEntryItemLoaded(
              toDoEntry: state.toDoEntry,
              onChanged: (value) => context.read<TodoEntryItemCubit>().update()),
          onSecondaryTapDown: (detail){
            if(kIsWeb){
              _showPopupMenu(context,state.toDoEntry,detail.globalPosition);
            }
          },
          onLongPress: (){
            if(Platform.isAndroid){
              debugPrint("android上右鍵 ${state.toDoEntry.description}");
            }
          },
        );
      } else {
        return const ToDoEntryItemError();
      }
    });
  }

  void _showPopupMenu(BuildContext context, ToDoEntry toDoEntry, Offset position) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, 0, 0),
      items: const [
        PopupMenuItem<String>(
            value: 'Done',
            child: Text('刪除')),
      ],
      elevation: 8.0,
    ).then((value){
      if(value == 'Done'){
        debugPrint("刪除 ${toDoEntry.description}");
      }
    });
  }
}
