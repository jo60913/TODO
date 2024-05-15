import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/page/setting/bloc/setting_cubit.dart';
import 'package:todo/application/page/setting/view_states/setting_error.dart';
import 'package:todo/application/page/setting/view_states/setting_loaded.dart';
import 'package:todo/application/page/setting/view_states/setting_loading.dart';
import 'package:todo/domain/usecase/load_fcm_setting.dart';

import '../../core/page_config.dart';

class SettingPageProvider extends StatelessWidget {
  const SettingPageProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingCubit>(
      create: (context)=> SettingCubit(loadFCMSetting: LoadFCMSetting(toDoRepository: RepositoryProvider.of(context)))..getTokenSetting(),
      child: const SettingPage(),
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);
  static const pageConfig = PageConfig(
      icon: Icons.settings_rounded, name: 'settings', child: SettingPageProvider());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BlocBuilder<SettingCubit,SettingState>(
        builder: (context, state) {
          if(state is SettingLoadingState){
            return const SettingLoading();
          }else if(state is SettingLoadedState){
            return SettingLoaded(value: state.fcmValue);
          }else {
            return const SettingError();
          }
        }
      ),
    );
  }
}

