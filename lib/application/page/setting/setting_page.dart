import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/usecase/load_fcm_setting.dart';
import '../../../domain/repository/todo_repository.dart';
import '../../../domain/usecase/update_fcm_value.dart';
import '../../core/page_config.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);
  static const pageConfig = PageConfig(
      icon: Icons.settings_rounded, name: 'settings', child: SettingPage());

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool initFcmValue = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () => setState(() {
      _getFirstFCMValue();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder<bool>(
            future: _getFCMValue(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  // 请求成功，显示数据
                  return CheckboxListTile(
                    title: const Text("推播設定"),
                    value: initFcmValue,
                    onChanged: (value) {
                      setState(() {
                        initFcmValue = value?? false;
                      });
                      _updateFCMValue(value!, context);
                    },
                  );
                }
              } else {
                // 请求未结束，显示loading
                return const Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }

  Future<bool> _updateFCMValue(bool fcmValue, BuildContext context) {
    return UpdateFCMValue(
        toDoRepository: RepositoryProvider.of<ToDoRepository>(context))
        .call(fcmValue);
  }

  Future<bool> _getFCMValue() async {
    return LoadFCMSetting(toDoRepository: RepositoryProvider.of<ToDoRepository>(context)).call();
  }

  Future<void> _getFirstFCMValue() async {
    initFcmValue = await LoadFCMSetting(toDoRepository: RepositoryProvider.of<ToDoRepository>(context)).call();
  }
}

