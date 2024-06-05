part of 'create_todo_collection_page_cubit.dart';

class CreateTodoCollectionPageState extends Equatable {
  final String? title;
  final int itemIndex;

  const CreateTodoCollectionPageState({this.title, this.itemIndex = 0});

  CreateTodoCollectionPageState copyWith({String? title, int? index}) {
    return CreateTodoCollectionPageState(
        itemIndex: index?? itemIndex, title: title ?? this.title);
  }

  @override
  List<Object?> get props => [title, itemIndex];
}