part of 'create_to_do_entry_page_cubit.dart';

class CreateTodoEntryPageState extends Equatable {
  final FormValue<String>? description;

  const CreateTodoEntryPageState({this.description});

  CreateTodoEntryPageState copyWith({FormValue<String>? description}) {
    return CreateTodoEntryPageState(description: description ?? description);
  }

  @override
  List<Object?> get props => [description];
}
