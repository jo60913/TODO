import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/application/component/todo_entry_item/todo_entry_item.dart';
import 'package:todo/application/page/create_todo_entry/create_todo_entry_page.dart';
import 'package:todo/application/page/detail/bloc/to_do_detail_cubit.dart';
import 'package:todo/domain/entity/unique_id.dart';

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
              ListView.builder(
                itemCount: widget.entryIds.length,
                itemBuilder: (context, index) =>
                    GestureDetector(
                      child: ToDoEntryItemProvider(
                        entryId: widget.entryIds[index],
                        collectionId: widget.collectionId,
                      ),
                      onLongPress: (){},
                      onSecondaryTapDown: (detail){
                        if(kIsWeb){
                          debugPrint("右鍵 entry id ${widget.entryIds[index]}");
                          showPopupMenu(context,widget.entryIds[index],widget.collectionId,detail.globalPosition);
                        }
                      },
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
                              collectionId: widget.collectionId,
                              toDoEntryItemAddedCallback: context.read<ToDoDetailCubit>().fetch)),
                  child: const Icon(Icons.add_rounded),
                ),
              )
            ],
          ),
        ));
  }

  void showPopupMenu(BuildContext context, EntryId entryID,CollectionId collectionID, Offset position) async {
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
        debugPrint("刪除 collectionID ${collectionID} entryid${entryID}");
        //TODO 這邊到時候usecase要加await

        context.read<ToDoDetailCubit>().fetch();
      }
    });
  }
}


