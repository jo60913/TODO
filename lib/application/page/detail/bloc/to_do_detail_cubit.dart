import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/use_case.dart';

import '../../../../domain/entity/unique_id.dart';
import '../../../../domain/usecase/load_todo_entry_ids_for_collection.dart';

part 'to_do_detail_state.dart';

class ToDoDetailCubit extends Cubit<ToDoDetailCubitState> {
  final CollectionId collectionId;
  final LoadToDoEntryIdsForCollection loadToDoEntryIdsForCollection;
  ToDoDetailCubit({required this.collectionId,required this.loadToDoEntryIdsForCollection}) : super(ToDoDetailCubitLoadingState());

  Future<void> fetch() async{
    emit(ToDoDetailCubitLoadingState());
    try{
      final entryIds = await loadToDoEntryIdsForCollection.call(CollectionIdsParam(collectionId: collectionId));
      if(entryIds.isLeft){
        emit(ToDoDetailCubitErrorState());
      }else{
        emit(ToDoDetailCubitLoadedState(entryIds: entryIds.right));
      }
    }on Exception{
      emit(ToDoDetailCubitErrorState());
    }
  }
}
