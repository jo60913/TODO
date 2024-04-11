import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entity/unique_id.dart';

part 'navigation_todo_state.dart';

class NavigationTodoCubit extends Cubit<NavigationTodoCubitState> {
  NavigationTodoCubit() : super(const NavigationTodoCubitState());

  void selectedToDoCollectionChanged(CollectionId collectionId) {
    emit(NavigationTodoCubitState(selectedCollectionId: collectionId));
  }

  void secondBodyHasChange({required bool isSecondBodyDisplay}) {
    if(isSecondBodyDisplay != state.isSecondBodyIsDisplayed) {
      emit(NavigationTodoCubitState(
          isSecondBodyIsDisplayed: isSecondBodyDisplay,
          selectedCollectionId: state.selectedCollectionId));
    }
  }

  void refreshToDoList(){
    emit(const NavigationTodoCubitState(selectedCollectionId: null));
  }
}
