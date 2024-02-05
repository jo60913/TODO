import 'package:flutter/material.dart';

class GoRouterObserver extends NavigatorObserver {
  GoRouterObserver();

  @override
  void didPush(Route<dynamic> route, Route? previousRoute) {
    debugPrint(
        'didPush ${route.settings.name} 前一頁 ${previousRoute?.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    debugPrint(
        'didReplace ${newRoute?.settings.name} 前一頁 ${oldRoute?.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route? previousRoute) {
    debugPrint(
        'didRemove ${route.settings.name} 前一頁 ${previousRoute?.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route? previousRoute) {
    debugPrint('didPop ${route.settings.name}');
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    debugPrint('didStartUserGesture ${route.settings.name} 前一頁 ${previousRoute
        ?.settings.name}');
  }

  @override
  void didStopUserGesture() {
    debugPrint('didStopUserGesture');
  }
}
