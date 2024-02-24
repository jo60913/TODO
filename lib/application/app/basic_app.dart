import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/application/page/home/bloc/navigation_todo_cubit.dart';

import '../core/routes.dart';

class BaseApp extends StatelessWidget {
  const BaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationTodoCubit>(
      create: (context) => NavigationTodoCubit(),
      child: MaterialApp.router(
        title: 'todo',
        localizationsDelegates: const [
          ...GlobalMaterialLocalizations.delegates,
          GlobalWidgetsLocalizations.delegate
        ],
        themeMode: ThemeMode.system,
        //依照系統設定明亮、晚上主題
        theme: ThemeData.from(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepOrange, brightness: Brightness.light)),
        darkTheme: ThemeData.from(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor:
                Colors.deepOrange)),
        //用deepOrange產生符合MaterialDesigh一系列的顏色
        routerConfig: routes,
      ),
    );
  }
}
