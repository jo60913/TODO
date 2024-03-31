part of 'todo_entry_delete_cubit.dart';

abstract class TodoEntryDeleteState extends Equatable {
  const TodoEntryDeleteState();

  @override
  List<Object> get props => [];
}

class TodoEntryDeleteLoadingState extends TodoEntryDeleteState {
  const TodoEntryDeleteLoadingState();
}

class ToDoEntryDeleteSuccessState extends TodoEntryDeleteState {
  final bool result;
  const ToDoEntryDeleteSuccessState({required this.result});

  @override
  List<Object> get props => [result];
}

class ToDoEntryDeleteErrorState extends TodoEntryDeleteState {
  const ToDoEntryDeleteErrorState();
}
