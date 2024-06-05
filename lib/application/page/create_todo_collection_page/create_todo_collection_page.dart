import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/application/core/page_config.dart';
import 'package:todo/application/page/create_todo_collection_page/bloc/create_todo_collection_page_cubit.dart';
import 'package:todo/resource/app_color_array.dart';
import '../../../domain/repository/todo_repository.dart';
import '../../../domain/usecase/create_todo_collection.dart';

List<String> _dropDownItem = ["重要/緊急","重要/不緊急","不重要/緊急","不重要/不緊急"];
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
  String _dropdownValue = _dropDownItem.first;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key : _formKey,
        child: Column(
          children: [
            Row(
              children: [
                const Text("重要程度",style: TextStyle(fontSize: 15),),
                const SizedBox(width: 10,),
                DropdownButton<String>(
                    value: _dropdownValue,
                    items: _dropDownItem
                        .map<DropdownMenuItem<String>>((String value) {
                      int index = _dropDownItem.indexOf(value);
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            CircleAvatar(radius:10,backgroundColor: AppColorArray.collectionEntryPriority[index],),
                            const SizedBox(height: 20),
                            Text(value)
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value){
                      context.read<CreateTodoCollectionPageCubit>().itemChange(_dropDownItem.indexOf(value!));
                      setState(() {
                        _dropdownValue = value;
                      });
                    }),
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "標題",labelStyle: TextStyle(fontSize: 15)),
              onChanged: (value)=>context.read<CreateTodoCollectionPageCubit>().titleChange(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '請輸入標題';
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
                context.read<CreateTodoCollectionPageCubit>().submit().then((value) => context.pop(true));
              }
            }, child: const Text('儲存'))
          ],
        ),
      ),
    );
  }
}
