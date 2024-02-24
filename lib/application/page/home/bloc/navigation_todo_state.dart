part of 'navigation_todo_cubit.dart';

class NavigationTodoCubitState extends Equatable {
  final CollectionId? selectedCollectionId;
  final bool? isSecondBodyIsDisplayed;

  const NavigationTodoCubitState({this.selectedCollectionId,this.isSecondBodyIsDisplayed});

  @override
  List<Object?> get props =>[selectedCollectionId,isSecondBodyIsDisplayed];
}

