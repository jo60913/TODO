import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/application/page/create_todo_collection_page/create_todo_collection_page.dart';
import 'package:todo/application/page/create_todo_entry/create_todo_entry_page.dart';
import 'package:todo/application/page/dashboard/dashboard.dart';
import 'package:todo/application/page/detail/todo_detail.dart';
import 'package:todo/application/page/home/home.dart';
import 'package:todo/application/page/overview/overview_page.dart';
import 'package:todo/application/page/setting/setting_page.dart';
import 'package:todo/domain/entity/unique_id.dart';

import 'go_router_observer.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');
const String _basePath = "/home";

final routes = GoRouter(
    initialLocation: '$_basePath/${DashBoardPage.pageConfig.name}',
    observers: [GoRouterObserver()],
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
          name: SettingPage.pageConfig.name,
          path: '$_basePath/${SettingPage.pageConfig.name}',
          builder: (context, state) {
            return const SettingPage();
          }),
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => child,
          routes: [
            GoRoute(
                name: HomePage.pageConfig.name,
                path: '$_basePath/:tab',
                builder: (context, state) => HomePage(
                      key: state.pageKey,
                      tab: state.params['tab']!,
                    ))
          ]),
      GoRoute(
          name: CreateToDoCollectionPage.pageConfig.name,
          path: "$_basePath/overview/${CreateToDoCollectionPage.pageConfig.name}",
          builder: (context, state) => Scaffold(
                appBar: AppBar(
                  title: const Text('新增'),
                  leading: BackButton(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.goNamed(HomePage.pageConfig.name,
                            params: {'tab': OverViewPage.pageConfig.name});
                      }
                    },
                  ),
                ),
            body: SafeArea(
              child: CreateToDoCollectionPage.pageConfig.child,
            ),
              )),
      GoRoute(
          name: CreateToDoEntryPage.pageConfig.name,
          path: "$_basePath/overview/${CreateToDoEntryPage.pageConfig.name}",
          builder: (context, state) {
            final castedExtra = state.extra as CreateToDoEntryPageExtra;
            return Scaffold(
            appBar: AppBar(
              title: const Text('新增'),
              leading: BackButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.goNamed(HomePage.pageConfig.name,
                        params: {'tab': OverViewPage.pageConfig.name});
                  }
                },
              ),
            ),
            body: SafeArea(
              child: CreateToDoEntryPageProvider(
                toDoEntryItemAddedCallback: castedExtra.toDoEntryItemAddedCallback,
                collectionId: castedExtra.collectionId,),
            ),
          );}),
      GoRoute(
          name: ToDoDetailPage.pageConfig.name,
          path: '$_basePath/overview/:collectionId',
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('details'),
                  leading: BackButton(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.goNamed(HomePage.pageConfig.name,
                            params: {'tab': OverViewPage.pageConfig.name});
                      }
                    },
                  ),
                ),
                body: ToDoDetailPageProvider(
                  collectionId: CollectionId.fromUniqueString(
                      state.params['collectionId'] ?? ''),
                ),
              );
          })
    ]);
