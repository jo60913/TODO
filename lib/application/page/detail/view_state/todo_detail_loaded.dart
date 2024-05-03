import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/application/component/todo_entry_item/todo_entry_item.dart';
import 'package:todo/application/page/create_todo_entry/create_todo_entry_page.dart';
import 'package:todo/application/page/detail/bloc/to_do_detail_cubit.dart';
import 'package:todo/domain/entity/todo_entry.dart';
import 'package:todo/domain/entity/unique_id.dart';

import '../../../../core/use_case.dart';
import '../../../../domain/repository/todo_repository.dart';
import '../../../../domain/usecase/delete_todo_entry.dart';
import '../delete_todo_entry/bloc/todo_entry_delete_cubit.dart';


class ToDoDetailLoaded extends StatefulWidget {
  final List<EntryId> entryIds;
  final CollectionId collectionId;

  const ToDoDetailLoaded(
      {super.key, required this.collectionId, required this.entryIds});

  @override
  State<ToDoDetailLoaded> createState() => _ToDoDetailLoadedState();
}

class _ToDoDetailLoadedState extends State<ToDoDetailLoaded> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              widget.entryIds.isNotEmpty ? ListView.builder(
                itemCount: widget.entryIds.length,
                itemBuilder: (context, index) =>
                    GestureDetector(
                      child: ToDoEntryItemProvider(
                        entryId: widget.entryIds[index],
                        collectionId: widget.collectionId,
                      ),
                      onLongPress: (){
                        if(Platform.isAndroid){
                          debugPrint("android按下");
                          showPopupMenu(context,widget.entryIds[index],widget.collectionId,Offset(50 , 100));
                        }
                      },
                      onSecondaryTapDown: (detail){
                        if(kIsWeb){
                          debugPrint("右鍵 entry id ${widget.entryIds[index]}");
                          showPopupMenu(context,widget.entryIds[index],widget.collectionId,detail.globalPosition);
                        }
                      },
                    ),
              ) : const Center(child: Text("沒有資料 請點選右下角+新增"),),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  key: const Key('create-todo-entry'),
                  heroTag: 'create-todo-entry',
                  onPressed: () =>
                      context.pushNamed(
                          CreateToDoEntryPage.pageConfig.name,
                          extra: CreateToDoEntryPageExtra(
                              collectionId: widget.collectionId,
                              toDoEntryItemAddedCallback: context.read<ToDoDetailCubit>().fetch)),
                  child: const Icon(Icons.add_rounded),
                ),
              )
            ],
          ),
        ));
  }

  void showPopupMenu(
    BuildContext context,
    EntryId entryID,
    CollectionId collectionID,
    Offset position,
  ) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, 0, 0),
      items: const [
        PopupMenuItem<String>(value: 'Done', child: Text('刪除')),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value == 'Done') {
        TodoEntryDeleteCubit(
          usecase: DeleteToDoEntry(
              toDoRepository: RepositoryProvider.of<ToDoRepository>(context)),
          params: ToDoEntryParams(
              collectionId: collectionID,
              entry: ToDoEntry(description: '', id: entryID, isDone: false)),
        )..deleteToDoCollections()
            .then((value) => context.read<ToDoDetailCubit>().fetch());
        // BlocProvider<TodoEntryDeleteCubit>(
        //   create:(context)=> TodoEntryDeleteCubit(
        //     usecase: DeleteToDoEntry(toDoRepository: RepositoryProvider.of<ToDoRepository>(context)),
        //     params: ToDoEntryParams(collectionId: collectionID,entry: ToDoEntry(description: '', id: entryID, isDone: false)),
        //   )..deleteToDoCollections(),
        //   child: Dialog()
        // );
      }
    });
  }
}
