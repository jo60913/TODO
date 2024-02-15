import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/application/page/setting/setting_page.dart';
import '../../core/page_config.dart';
import '../dashboard/dashboard.dart';
import '../overview/overview_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required String tab})
      : index = tabs.indexWhere((element) => element.name == tab);

  final int index;

  static const PageConfig pageConfig = PageConfig(
    icon: Icons.home_rounded,
    name: 'home',
  );

  static const tabs = [DashBoardPage.pageConfig, OverViewPage.pageConfig];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final destination = HomePage.tabs
      .map((page) =>
          NavigationDestination(icon: Icon(page.icon), label: page.name))
      .toList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: AdaptiveLayout(
          primaryNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                  key: const Key('primary-navigation-medium'),
                  builder: (context) => AdaptiveScaffold.standardNavigationRail(
                    trailing: IconButton(onPressed: ()=>context.pushNamed(SettingPage.pageConfig.name), icon: Icon(SettingPage.pageConfig.icon)),
                      selectedLabelTextStyle:
                          TextStyle(color: theme.colorScheme.onBackground),
                      selectedIconTheme:
                          IconThemeData(color: theme.colorScheme.onBackground),
                      unselectedIconTheme: IconThemeData(
                          color:
                              theme.colorScheme.onBackground.withOpacity(0.5)),
                      onDestinationSelected: (index) =>
                          _tapOnNavigationDestination(context, index),
                      selectedIndex: widget.index,
                      destinations: destination
                          .map((_) => AdaptiveScaffold.toRailDestination(_))
                          .toList()))
            },
          ),
          bottomNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.small: SlotLayout.from(
                  key: const Key('bottom-navigation-smell'),
                  builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
                      destinations: destination,
                      onDestinationSelected: (index) =>
                          _tapOnNavigationDestination(context, index),
                      currentIndex: widget.index))
            },
          ),
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.smallAndUp: SlotLayout.from(
                  key: const Key('primary-body-small'),
                  builder: (_) => HomePage.tabs[widget.index].child)
            },
          ),
          secondaryBody: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                  key: const Key('secondary-body-medium'),
                  builder: AdaptiveScaffold.emptyBuilder)
            },
          ),
        ),
      ),
    );
  }

  void _tapOnNavigationDestination(BuildContext context, int index) =>
      context.goNamed(HomePage.pageConfig.name, params: {
        'tab': HomePage.tabs[index].name,
      });
}
