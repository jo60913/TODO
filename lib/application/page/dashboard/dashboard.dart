import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/core/page_config.dart';
import 'package:todo/application/page/dashboard/bloc/todo_dashboard_cubit.dart';
import 'package:todo/application/page/dashboard/view_states/todo_dashboard_loaded.dart';
import 'package:todo/application/page/dashboard/view_states/todo_dashboard_loading.dart';
import '../../../domain/usecase/load_todo_collection_and_entry.dart';
import 'view_states/todo_dashboard_error.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  static const pageConfig = PageConfig(
      icon: Icons.dashboard_rounded, name: 'dashboard', child: DashBoardProvider());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoDashboardCubit,ToDoDashboardState>(
      builder: (context,state){
        if(state is ToDoDashboardLoaded){
          return ToDoDashBoardLoadedPage(collections: state.collectionAndEntry);
        }else if(state is ToDoDashboardLoading){
          return const TodoDashboardLoadingPage();
        }else{
          return const TodoDashboardErrorPage();
        }
      },
    );
  }
}

class DashBoardProvider extends StatelessWidget {
  const DashBoardProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoDashboardCubit>(
        create: (context) => TodoDashboardCubit(
              loadToDoCollectionsAndEntry: LoadToDoCollectionAndEntry(
                  toDoRepository: RepositoryProvider.of(context)),
            )..readToDoCollections(),
        child: const DashBoardPage());
  }
}


