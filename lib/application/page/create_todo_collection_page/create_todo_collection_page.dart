import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/application/core/page_config.dart';
import 'package:todo/application/page/create_todo_collection_page/bloc/create_todo_collection_page_cubit.dart';
import 'package:todo/domain/entity/todo_color.dart';
import '../../../domain/repository/todo_repository.dart';
import '../../../domain/usecase/create_todo_collection.dart';


class CreateToDoCollectionPageProvider extends StatelessWidget {
  const CreateToDoCollectionPageProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTodoCollectionPageCubit>(
      create: (context) => CreateTodoCollectionPageCubit(
        createTodoCollection: CreateToDoCollection(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      ),
      child: const CreateToDoCollectionPage(),
    );
  }
}

class CreateToDoCollectionPage extends StatefulWidget {
  static const pageConfig = PageConfig(
    icon: Icons.add_task_rounded,
    name: 'create_todo_collection',
    child: CreateToDoCollectionPageProvider(),
  );

  const CreateToDoCollectionPage({super.key});

  @override
  State<CreateToDoCollectionPage> createState() =>
      _CreateToDoCollectionPageState();
}

class _CreateToDoCollectionPageState extends State<CreateToDoCollectionPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key : _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "標題"),
              onChanged: (value)=>context.read<CreateTodoCollectionPageCubit>().titleChange(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '請輸入標題';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "顏色"),
              onChanged: (value)=>context.read<CreateTodoCollectionPageCubit>().colorChange(value),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final parseColorIndex = int.parse(value);
                  if (parseColorIndex == null ||
                      parseColorIndex < 0 ||
                      parseColorIndex > ToDoColor.predefinedColors.length) {
                    return '請輸入0到${ToDoColor.predefinedColors.length - 1}之間的數';
                  }
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(onPressed: (){
              final isValide = _formKey.currentState?.validate();   //用來辨識所有當中所有欄位的validator是否正確為null代表為true
              if(isValide == true) {
                context.read<CreateTodoCollectionPageCubit>().submit().then((value) => context.pop(true)).then((value) => context.pop(true),);
              }
            }, child: const Text('儲存'))
          ],
        ),
      ),
    );
  }
}
