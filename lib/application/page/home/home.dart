import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/application/page/detail/todo_detail.dart';
import 'package:todo/application/page/home/bloc/navigation_todo_cubit.dart';
import 'package:todo/application/page/home/component/login_button.dart';
import 'package:todo/application/page/setting/setting_page.dart';
import '../../core/constants.dart';
import '../../core/page_config.dart';
import '../dashboard/dashboard.dart';
import '../overview/overview_page.dart';

class HomePageProvider extends StatelessWidget {
  const HomePageProvider({super.key, required this.tab});

  final String tab;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationTodoCubit>(
      create: (_) => NavigationTodoCubit(),
      child: HomePage(tab: tab),
    );
  }
}

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
    return Scaffold(
      body: SafeArea(
        child: BlocListener<NavigationTodoCubit, NavigationTodoCubitState>(
          listenWhen: (previous, current) =>
              previous.isSecondBodyIsDisplayed !=
              current.isSecondBodyIsDisplayed,
          listener: (context, state) {
            if (context.canPop() && (state.isSecondBodyIsDisplayed ?? false)) {
              context.pop();
            }
          },
          child: AdaptiveLayout(
            primaryNavigation: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.mediumAndUp: SlotLayout.from(
                    key: const Key('primary-navigation-medium'),
                    builder: (context) =>
                        AdaptiveScaffold.standardNavigationRail(
                            trailing: IconButton(
                                onPressed: () => context
                                    .pushNamed(SettingPage.pageConfig.name),
                                icon: Icon(SettingPage.pageConfig.icon)),
                            onDestinationSelected: (index) =>
                                _tapOnNavigationDestination(context, index),
                            leading: const LoginButton(),
                            selectedIndex: widget.index,
                            destinations:
                                destination
                                    .map((_) =>
                                        AdaptiveScaffold.toRailDestination(_))
                                    .toList())),
              },
            ),
            topNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.small: SlotLayout.from(
                  key: const Key('top-navigation-small'),
                  builder: (context) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                            onPressed: () =>
                                context.pushNamed(SettingPage.pageConfig.name),
                            icon: Icon(SettingPage.pageConfig.icon),
                          ),
                          const LoginButton(),
                    ],
                  ))
            }),
            bottomNavigation: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.small: SlotLayout.from(
                    key: const Key('bottom-navigation-smell'),
                    builder: (_) =>
                        AdaptiveScaffold.standardBottomNavigationBar(
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
                    builder: (_) => HomePage.tabs[widget.index].child),
              },
            ),
            secondaryBody: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.mediumAndUp: SlotLayout.from(
                    key: const Key('secondary-body-medium'),
                    builder: widget.index != PageIndex.overViewPageIndex
                        ? null
                        : (_) => BlocBuilder<NavigationTodoCubit,
                                NavigationTodoCubitState>(
                              builder: (context, state) {
                                final selectId = state.selectedCollectionId;
                                final isSecondBodyDisplay =
                                    Breakpoints.mediumAndUp.isActive(context);

                                context
                                    .read<NavigationTodoCubit>()
                                    .secondBodyHasChange(
                                        isSecondBodyDisplay:
                                            isSecondBodyDisplay);

                                if (selectId == null) {
                                  return const Placeholder();
                                } else {
                                  return ToDoDetailPageProvider(
                                      key: Key(selectId.value),
                                      //當key不壹樣的時候flutter就會刷新
                                      collectionId: selectId);
                                }
                              },
                            ))
              },
            ),
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
