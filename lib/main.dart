import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/app/basic_app.dart';
import 'package:todo/data/data_source/local/hive_local_data_source.dart';
import 'package:todo/data/repository/todo_repository_local.dart';
import 'package:todo/domain/repository/todo_repository.dart';

void main() {
  final dataSource = HiveLocalDataSource();
  dataSource.init();
  runApp(RepositoryProvider<ToDoRepository>(
      create: (context) =>
          ToDoRepositoryLocal(localDataSource: dataSource),
      child: const BaseApp()));
}
