
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/api/get_token_response.dart';
import '../../../../domain/usecase/load_fcm_setting.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final LoadFCMSetting loadFCMSetting;
  SettingCubit({required this.loadFCMSetting}) : super(SettingLoadingState());

  Future<void> getTokenSetting ()async{
    debugPrint("執行getTokenSetting方法");
    emit(SettingLoadingState());
    try{
      var token = FirebaseAuth.instance.currentUser?.uid;
      debugPrint("token為${token}");
      var result = await loadFCMSetting.call(token!);
      debugPrint("取得設定的方法 ${result.right}");
      if(result.isLeft){
        emit(SettingErrorState());
      }else{
        emit(SettingLoadedState(fcmValue: result.right));
      }
    }on Exception catch(e){
      debugPrint("取得token設定時錯誤 $e");
      emit(SettingErrorState());
    }
  }
}
