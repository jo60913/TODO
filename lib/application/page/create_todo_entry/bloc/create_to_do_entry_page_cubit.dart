import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/core/form_value.dart';
import 'package:todo/core/use_case.dart';
import 'package:todo/domain/entity/todo_entry.dart';

import '../../../../domain/entity/unique_id.dart';
import '../../../../domain/usecase/create_todo_entry.dart';

part 'create_to_do_entry_page_state.dart';

class CreateToDoEntryPageCubit extends Cubit<CreateTodoEntryPageState> {
  final CollectionId collectionId;
  final CreateToDoEntry addToDoEntry;

  CreateToDoEntryPageCubit(
      {required this.collectionId, required this.addToDoEntry})
      : super(const CreateTodoEntryPageState());

  void descriptionChanged({String? description}) {
    ValidationStatus currentStatus = ValidationStatus.pending;
    if (description == null || description.isEmpty || description.length < 2) {
      currentStatus = ValidationStatus.error;
    } else {
      currentStatus = ValidationStatus.success;
    }
    emit(state.copyWith(
        description:
            FormValue(value: description!, validationStatus: currentStatus)));
  }

  void submit() async{
    await addToDoEntry.call(
      ToDoEntryParams(
        collectionId: collectionId,
        entry: ToDoEntry.empty().copyWith(
            description: state.description?.value),
      ),
    );
  }
}
