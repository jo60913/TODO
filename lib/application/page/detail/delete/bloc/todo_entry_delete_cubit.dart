import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/use_case.dart';
import '../../../../../domain/usecase/delete_todo_entry.dart';

part 'todo_entry_delete_state.dart';

class TodoEntryDeleteCubit extends Cubit<TodoEntryDeleteState> {
  final DeleteToDoEntry usecase;
  final ToDoEntryParams params;
  TodoEntryDeleteCubit({required this.usecase,required this.params}) : super(const TodoEntryDeleteLoadingState());

  Future<void> deleteToDoCollections() async {
    debugPrint("deletetodocollection 執行");
    emit(const TodoEntryDeleteLoadingState());
    try{
      final collectionFuture = await usecase.call(params);

      if(collectionFuture.isLeft){
        emit(const ToDoEntryDeleteErrorState());
      }else{
        emit(ToDoEntryDeleteSuccessState(result: collectionFuture.right));
      }
    } on Exception catch(e){
      emit(const ToDoEntryDeleteErrorState());
    }
  }
}
