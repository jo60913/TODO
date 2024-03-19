import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/use_case.dart';
import '../../../../domain/entity/todo_entry.dart';
import '../../../../domain/entity/unique_id.dart';
import '../../../../domain/usecase/load_todo_entry.dart';
import '../../../../domain/usecase/update_todo_entry.dart';

part 'todo_entry_item_state.dart';

class TodoEntryItemCubit extends Cubit<TodoEntryItemState> {
  final EntryId entryId;
  final CollectionId collectionId;
  final LoadToDoEntry loadToDoEntry;
  final UpdateToDoEntry uploadToDoEntry;

  TodoEntryItemCubit({
    required this.entryId,
    required this.collectionId,
    required this.loadToDoEntry,
    required this.uploadToDoEntry,
  }) : super(TodoEntryItemLoadingState());

  Future<void> fetch() async {
    try {
      final entry = await loadToDoEntry.call(ToDoEntryIdsParam(
        collectionId: collectionId,
        entryId: entryId,
      ));

      return entry.fold(
        (left) => emit(TodoEntryItemErrorState()),
        (right) => emit(TodoEntryItemLoadedState(toDoEntry: right)),
      );
    } on Exception {
      emit(TodoEntryItemErrorState());
    }
  }

  Future<void> update() async {
    try {
      if (state is TodoEntryItemLoadedState) {
        final currentEntry = (state as TodoEntryItemLoadedState).toDoEntry;
        final entryToUpdate =
            currentEntry.copyWith(isDone: !currentEntry.isDone);
        final updateEntry = await uploadToDoEntry.call(
            ToDoEntryParams(collectionId: collectionId, entry: entryToUpdate));
        return updateEntry.fold((left) => emit(TodoEntryItemErrorState()),
            (right) => emit(TodoEntryItemLoadedState(toDoEntry: right)));
      }
    } on Exception {
      emit(TodoEntryItemErrorState());
    }
  }
}
