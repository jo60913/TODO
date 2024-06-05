import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/core/page_config.dart';
import 'package:todo/application/page/overview/bloc/todo_overview_cubit.dart';
import 'package:todo/application/page/overview/view_states/todo_overview_error.dart';
import 'package:todo/application/page/overview/view_states/todo_overview_loaded.dart';
import 'package:todo/application/page/overview/view_states/todo_overview_loading.dart';
import 'package:todo/domain/usecase/load_todo_collections.dart';

import '../../../resource/app_string.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({super.key});

  static const pageConfig = PageConfig(
      icon: Icons.work_history_rounded,
      name: AppString.overviewTitle,
      child: OverviewPageProvider());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BlocBuilder<ToDoOverviewCubit, ToDoOverviewCubitState>(
        builder: (context, state) {
          if (state is ToDoOverviewCubitLoadingState) {
            return const ToDoOverviewLoading();
          } else if (state is ToDoOverviewCubitLoadedState) {
            return ToDoOverviewLoaded(collections: state.collections);
          } else {
            return const ToDoOverviewError();
          }
        },
      ),
    );
  }
}

class OverviewPageProvider extends StatelessWidget {
  const OverviewPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToDoOverviewCubit>(
      create: (context) => ToDoOverviewCubit(
          loadToDoCollections: LoadToDoCollections(
              toDoRepository: RepositoryProvider.of(context)),)
        ..readToDoCollections(),
      child: const OverViewPage(),
    );
  }
}
