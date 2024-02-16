import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/use_case.dart';

import '../../../../domain/entity/todo_collection.dart';
import '../../../../domain/usecase/load_todo_collections.dart';

part 'todo_overview_cubit_state.dart';

class ToDoOverviewCubit extends Cubit<ToDoOverviewCubitState> {
  ToDoOverviewCubit(
      {required this.loadToDoCollections, ToDoOverviewCubitState? initialState})
      : super(initialState ?? ToDoOverviewCubitLoadingState());
  final LoadToDoCollections loadToDoCollections;

  Future<void> readToDoCollections() async {
    emit(ToDoOverviewCubitLoadingState());
    try{
      final collectionFuture = loadToDoCollections.call(NoParams());
      final collections = await collectionFuture;

      if(collections.isLeft){
          emit(ToDoOverviewCubitErrorState());
      }else{
          emit(ToDoOverviewCubitLoadedState(collections: collections.right));
      }
    } on Exception{
      emit(ToDoOverviewCubitErrorState());
    }
  }
}
