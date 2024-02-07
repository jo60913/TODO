import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/application/page/home/home.dart';

import 'go_router_observer.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final routes = GoRouter(
    initialLocation: '/home/dashboard',
    observers: [GoRouterObserver()],
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
          path: '/home/settings',
          builder: (context, state) {
            return Container(
              color: Colors.amber,
              child: Column(
                children: [
                  ElevatedButton(
                    child: const Text('Go to start'),
                    onPressed: () => context.push('/home/start'),
                  ),
                  TextButton(
                      onPressed: () => {
                            if (context.canPop())
                              {context.pop()}
                            else
                              {context.push('/home/start')}
                          },
                      child: const Text('go back'))
                ],
              ),
            );
          }),
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => child,
          routes: [
            GoRoute(
                path: '/home/:tab',
                builder: (context, state) => HomePage(
                      key: state.pageKey,
                      tab: state.params['tab']!,
                    ))
          ]),
      GoRoute(
          path: '/home/start',
          builder: (context, state) {
            return Container(
              color: Colors.blueGrey,
              child: Column(
                children: [
                  ElevatedButton(
                    child: const Text('Go to setting'),
                    onPressed: () => context.push('/home/settings'),
                  ),
                  TextButton(
                      onPressed: () => {
                            if (context.canPop())
                              {context.pop()}
                            else
                              {context.push('/home/settings')}
                          },
                      child: const Text('go back'))
                ],
              ),
            );
          })
    ]);
