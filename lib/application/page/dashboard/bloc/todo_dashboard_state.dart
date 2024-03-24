part of 'todo_dashboard_cubit.dart';

abstract class ToDoDashboardState extends Equatable {
  const ToDoDashboardState();

  @override
  List<Object> get props => [];
}

class ToDoDashboardLoading extends ToDoDashboardState {
  const ToDoDashboardLoading();
}

class ToDoDashboardError extends ToDoDashboardState {
  const ToDoDashboardError();
}

class ToDoDashboardLoaded extends ToDoDashboardState {
  final List<ToDoCollectionAndEntry> collectionAndEntry;
  const ToDoDashboardLoaded({required this.collectionAndEntry});
}