import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/application/page/create_todo_collection_page/create_todo_collection_page.dart';
import 'package:todo/application/page/detail/todo_detail.dart';
import 'package:todo/application/page/home/bloc/navigation_todo_cubit.dart';
import 'package:todo/application/page/overview/bloc/todo_overview_cubit.dart';
import 'package:todo/core/use_case.dart';
import 'package:todo/domain/entity/unique_id.dart';
import 'package:todo/domain/usecase/delete_todo_collection.dart';
import 'package:todo/resource/app_color.dart';
import 'package:todo/resource/app_color_array.dart';
import '../../../../domain/entity/todo_collection.dart';
import '../../../../domain/repository/todo_repository.dart';
import '../../../../resource/app_string.dart';

//代辦事項的集合
class ToDoOverviewLoaded extends StatelessWidget {
  const ToDoOverviewLoaded({super.key, required this.collections});

  final List<ToDoCollection> collections;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        collections.isNotEmpty ?ListView.builder(
            itemCount: collections.length,
            itemBuilder: (context, index) {
              final item = collections[index];
              final colorScheme = Theme.of(context).colorScheme;

              return BlocBuilder<NavigationTodoCubit, NavigationTodoCubitState>(
                  buildWhen: (previous, current) =>
                      previous.selectedCollectionId !=
                      current.selectedCollectionId,
                  builder: (context, state) => ListTile(
                        tileColor: colorScheme.surface,
                        selectedTileColor: colorScheme.surfaceVariant,
                        iconColor: AppColorArray.collectionEntryPriority[item.itemIndex],
                        selectedColor:AppColorArray.collectionEntryPriority[item.itemIndex],
                        selected: item.id == state.selectedCollectionId,
                        onTap: () {
                          //小螢幕延展的時候也會用到，所以寫到最前面
                          context
                              .read<NavigationTodoCubit>()
                              .selectedToDoCollectionChanged(item.id);
                          if (Breakpoints.small.isActive(context)) {
                            context.pushNamed(ToDoDetailPage.pageConfig.name,
                                params: {'collectionId': item.id.value});
                          }
                        },
                        trailing: PopupMenuButton(
                          iconColor: AppColors.itemsGray,
                          itemBuilder: (context) {
                            return const [
                              PopupMenuItem(
                                value: 'delete',
                                child: Text(AppString.overviewDelete),
                              )
                            ];
                          },
                          onSelected: (String value){
                            if(value == 'delete'){
                             debugPrint(AppString.overviewDelete);
                             deleteCollection(item.id.value,context);
                            }
                          },
                        ),
                        leading: const Icon(Icons.circle),
                        title: Text(item.title),
                      ));
            }) : const Center(
          child: Text(AppString.overviewAddNewMissionCategory),
        ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                key: const Key('create-todo-collection'),
                heroTag: 'create-todo-collection',
                onPressed: () {
                  context.pushNamed(CreateToDoCollectionPage.pageConfig.name).then((value) {
                    if(value == true) {
                      context.read<ToDoOverviewCubit>().readToDoCollections();
                    }
                  });
                },
                child: Icon(CreateToDoCollectionPage.pageConfig.icon),
              ),
            ),
          )
      ],
    ) ;
  }

  void deleteCollection(String value, BuildContext context) {
    final usecase = DeleteToDoCollection(toDoRepository: RepositoryProvider.of<ToDoRepository>(context));
    usecase.call(CollectionIdsParam(collectionId: CollectionId.fromUniqueString(value)))
    .then((value) {
      context.read<ToDoOverviewCubit>().readToDoCollections();
      context.read<NavigationTodoCubit>().refreshToDoList();
    });
  }
}
