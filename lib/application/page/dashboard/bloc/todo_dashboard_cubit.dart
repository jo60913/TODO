import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/use_case.dart';
import '../../../../domain/entity/todo_collection_and_entry.dart';
import '../../../../domain/usecase/load_todo_collection_and_entry.dart';
part 'todo_dashboard_state.dart';

class TodoDashboardCubit extends Cubit<ToDoDashboardState> {
  final LoadToDoCollectionAndEntry loadToDoCollectionsAndEntry;
  TodoDashboardCubit(
      {required this.loadToDoCollectionsAndEntry, ToDoDashboardState? initialState})
      : super(initialState ?? const ToDoDashboardLoading());

  Future<void> readToDoCollections() async {
    emit(const ToDoDashboardLoading());
    try{
      final collections = await loadToDoCollectionsAndEntry.call(NoParams());
      if(collections.isLeft){
        emit(const ToDoDashboardError());
      }else{
        emit(ToDoDashboardLoaded(collectionAndEntry: collections.right));
      }
    } on Exception catch(e){
      emit(const ToDoDashboardError());
    }
  }
}
