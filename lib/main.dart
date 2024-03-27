

import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart'as ui_auth hide  EmailAuthProvider;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/app/basic_app.dart';
import 'package:todo/application/app/cubit/auth_cubit.dart';
import 'package:todo/data/data_source/remote/firestore_remote_data_source.dart';
import 'package:todo/data/repository/todo_repository_remote.dart';
import 'package:todo/domain/repository/todo_repository.dart';
import 'package:todo/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  window.document.onContextMenu.listen((evt) => evt.preventDefault());    //關閉網頁預設右鍵(會顯示上一頁、重新載入、列印等功能的視窗)

  if(!kIsWeb || !kDebugMode){   //Crashlytics不支援網頁，且非release模式也不使用不免測試的錯誤上傳到Crashlytics
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ui_auth.FirebaseUIAuth.configureProviders([
    ui_auth.PhoneAuthProvider(),
  ]);

  // final dataSource = HiveLocalDataSource();  //本機資料庫
  // dataSource.init();

  final remoteDataSource = FirestoreRemoteDataSource();

  final authCubit = AuthCubit();
  FirebaseAuth.instance.authStateChanges().listen((event) { //一但使用者登入或登出時就會觸發
    debugPrint("user是否為空${event == null}");
    authCubit.authStateChange(user: event);
  });

  runApp(RepositoryProvider<ToDoRepository>(
      create: (context) => ToDoRepositoryRemote(remoteSource: remoteDataSource),
      child: BlocProvider<AuthCubit>(
        create: (context) => authCubit,
        child: const BaseApp(),
      )));
}
