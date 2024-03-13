import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart'as ui_auth hide  EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/app/basic_app.dart';
import 'package:todo/application/app/cubit/auth_cubit.dart';
import 'package:todo/data/data_source/local/hive_local_data_source.dart';
import 'package:todo/data/repository/todo_repository_local.dart';
import 'package:todo/domain/repository/todo_repository.dart';
import 'package:todo/firebase_options.dart';

Future<void> main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ui_auth.FirebaseUIAuth.configureProviders([
    ui_auth.PhoneAuthProvider(),
  ]);

  final dataSource = HiveLocalDataSource();
  dataSource.init();
  final authCubit = AuthCubit();
  FirebaseAuth.instance.authStateChanges().listen((event) { //一但使用者登入或登出時就會觸發
    debugPrint("user是否為空${event == null}");
    authCubit.authStateChange(user: event);
  });

  runApp(RepositoryProvider<ToDoRepository>(
      create: (context) => ToDoRepositoryLocal(localDataSource: dataSource),
      child: BlocProvider<AuthCubit>(
        create: (context) => authCubit,
        child: const BaseApp(),
      )));
}
