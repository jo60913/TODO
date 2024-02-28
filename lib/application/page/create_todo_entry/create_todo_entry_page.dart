import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/application/core/form_value.dart';
import 'package:todo/application/page/create_todo_entry/bloc/create_to_do_entry_page_cubit.dart';
import 'package:todo/domain/entity/unique_id.dart';
import 'package:todo/domain/repository/todo_repository.dart';
import 'package:todo/domain/usecase/create_todo_entry.dart';

import '../../core/page_config.dart';

class CreateToDoEntryPageProvider extends StatelessWidget {
  final CollectionId collectionId;

  const CreateToDoEntryPageProvider({super.key, required this.collectionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateToDoEntryPageCubit>(
      create: (context) =>
          CreateToDoEntryPageCubit(
            collectionId: collectionId,
            addToDoEntry: CreateToDoEntry(toDoRepository: RepositoryProvider.of<ToDoRepository>(context)),),
      child: const CreateToDoEntryPage(),
    );
  }
}

class CreateToDoEntryPage extends StatefulWidget {
  const CreateToDoEntryPage({super.key});

  static const pageConfig = PageConfig(
      name: 'create_todo_entry',
      icon: Icons.add_task_rounded,
      child: Placeholder());

  @override
  State<CreateToDoEntryPage> createState() => _CreateToDoEntryPageState();
}

class _CreateToDoEntryPageState extends State<CreateToDoEntryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: '描述'),
                validator: (value) {
                  final currentValidationState = context
                      .read<CreateToDoEntryPageCubit>()
                      .state
                      .description
                      ?.validationStatus ??
                      ValidationStatus.pending;
                  switch (currentValidationState) {
                    case ValidationStatus.error:
                      return "至少需要輸入兩個字元";
                    case ValidationStatus.success:
                    case ValidationStatus.pending:
                  }
                },
                onChanged: (value) {
                  context
                      .read<CreateToDoEntryPageCubit>()
                      .descriptionChanged(description: value);
                },
              ),
              const SizedBox(height: 16,),
              ElevatedButton(
                  onPressed: () {
                    final isValid = _formKey.currentState?.validate();
                    if (isValid == true) {
                      context.read<CreateToDoEntryPageCubit>().submit();
                      context.pop();
                    }
                  },
                  child: const Text('新增'))
            ],
          )),
    );
  }
}
