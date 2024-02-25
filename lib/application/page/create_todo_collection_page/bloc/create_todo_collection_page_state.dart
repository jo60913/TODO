part of 'create_todo_collection_page_cubit.dart';

class CreateTodoCollectionPageState extends Equatable {
  final String? title;
  final String? color;

  const CreateTodoCollectionPageState({this.title, this.color});

  CreateTodoCollectionPageState copyWith({String? title, String? color}) {
    return CreateTodoCollectionPageState(
        color: color ?? this.color, title: title ?? this.title);
  }

  @override
  List<Object?> get props => [title, color];
}