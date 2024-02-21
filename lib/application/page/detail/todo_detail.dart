import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/core/page_config.dart';
import 'package:todo/application/page/detail/bloc/to_do_detail_cubit.dart';
import 'package:todo/application/page/detail/view_state/todo_detail_error.dart';
import 'package:todo/application/page/detail/view_state/todo_detail_loaded.dart';
import 'package:todo/application/page/detail/view_state/todo_detail_loading.dart';
import 'package:todo/domain/entity/unique_id.dart';
import 'package:todo/domain/repository/todo_repository.dart';
import 'package:todo/domain/usecase/load_todo_entry_ids_for_collection.dart';

class ToDoDetailPageProvider extends StatelessWidget {
  final CollectionId collectionId;

  const ToDoDetailPageProvider({super.key, required this.collectionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToDoDetailCubit>(
      create: (context) => ToDoDetailCubit(
          collectionId: collectionId,
          loadToDoEntryIdsForCollection: LoadToDoEntryIdsForCollection(
              toDoRepository: RepositoryProvider.of<ToDoRepository>(context)))..fetch(),
      child: ToDoDetailPage(collectionId: collectionId),
    );
  }
}

class ToDoDetailPage extends StatelessWidget {
  final CollectionId collectionId;

  const ToDoDetailPage({super.key, required this.collectionId});

  static const pageConfig = PageConfig(
      icon: Icons.details_rounded, name: 'detail', child: Placeholder());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoDetailCubit,ToDoDetailCubitState>(builder: (context, state) {
      if (state is ToDoDetailCubitLoadingState) {
        return const ToDoDetailLoading();
      } else if (state is ToDoDetailCubitLoadedState) {
        return ToDoDetailLoaded(
            collectionId: collectionId, entryIds: state.entryIds);
      } else {
        return const ToDoDetailError();
      }
    });
  }
}
