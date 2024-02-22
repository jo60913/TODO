part of 'todo_entry_item_cubit.dart';

abstract class TodoEntryItemState extends Equatable {
  const TodoEntryItemState();
  @override
  List<Object> get props => [];
}

class TodoEntryItemLoadingState extends TodoEntryItemState {}
class TodoEntryItemErrorState extends TodoEntryItemState {}
class TodoEntryItemLoadedState extends TodoEntryItemState {
  final ToDoEntry toDoEntry;
  const TodoEntryItemLoadedState({required this.toDoEntry});

  @override
  List<Object> get props => [toDoEntry];
}
