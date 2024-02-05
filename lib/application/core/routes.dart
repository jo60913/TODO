import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'go_router_observer.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final routes = GoRouter(
    initialLocation: '/home/start',
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
                        if (context.canPop()) {context.pop()}
                        else {context.push('/home/start')}
                      },
                      child: const Text('go back'))
                ],
              ),
            );
          }),
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
                            if (context.canPop()) {context.pop()}
                            else {context.push('/home/settings')}
                          },
                      child: const Text('go back'))
                ],
              ),
            );
          })
    ]);
