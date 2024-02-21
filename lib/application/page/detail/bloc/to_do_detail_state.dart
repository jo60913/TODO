part of 'to_do_detail_cubit.dart';

abstract class ToDoDetailCubitState extends Equatable {
  const ToDoDetailCubitState();

  @override
  List<Object> get props =>[];
}

class ToDoDetailCubitLoadingState extends ToDoDetailCubitState {}

class ToDoDetailCubitErrorState extends ToDoDetailCubitState {}

class ToDoDetailCubitLoadedState extends ToDoDetailCubitState {
  final List<EntryId> entryIds;
  const ToDoDetailCubitLoadedState({required this.entryIds});

  @override
  List<Object> get props =>[entryIds];
}
