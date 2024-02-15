import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/application/page/dashboard/dashboard.dart';
import 'package:todo/application/page/home/home.dart';
import 'package:todo/application/page/setting/setting_page.dart';

import 'go_router_observer.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');
const String _basePart = "/home";

final routes = GoRouter(
    initialLocation: '$_basePart/${DashBoardPage.pageConfig.name}',
    observers: [GoRouterObserver()],
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        name:SettingPage.pageConfig.name,
          path: '$_basePart/${SettingPage.pageConfig.name}',
          builder: (context, state) {
            return const SettingPage();
          }),
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => child,
          routes: [
            GoRoute(
              name: HomePage.pageConfig.name,
                path: '$_basePart/:tab',
                builder: (context, state) => HomePage(
                      key: state.pageKey,
                      tab: state.params['tab']!,
                    ))
          ]),
    ]);
