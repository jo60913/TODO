import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/use_case.dart';
import 'package:todo/domain/entity/todo_collection.dart';

import '../../../../domain/usecase/create_todo_collection.dart';

part 'create_todo_collection_page_state.dart';

class CreateTodoCollectionPageCubit
    extends Cubit<CreateTodoCollectionPageState> {
  final CreateToDoCollection createTodoCollection;

  CreateTodoCollectionPageCubit({required this.createTodoCollection})
      : super(const CreateTodoCollectionPageState());

  void titleChange(String title) {
    emit(state.copyWith(title: title));
  }

  void itemChange(int index) {
    emit(state.copyWith(index: index));
  }

  Future<void> submit() async {
    await createTodoCollection
        .call(ToDoCollectionParams(collection: ToDoCollection.empty().copyWith(
      title: state.title,
      itemIndex: state.itemIndex
    )));
  }
}
