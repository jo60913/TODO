import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class SettingLoaded extends StatefulWidget {
  bool value;
  SettingLoaded({Key? key,required this.value}) : super(key: key);

  @override
  State<SettingLoaded> createState() => _SettingLoadedState();
}

class _SettingLoadedState extends State<SettingLoaded> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: CheckboxListTile(
            title: const Text("推播設定"),
            value: widget.value,
            onChanged: (_){
              //TODO 在這邊從網路取得fcm的值來顯示
              setState(() {
                widget.value = !widget.value;
                if(widget.value){
                  FirebaseMessaging.instance.getToken();
                  debugPrint("value true Firebase getToken");
                }else{
                  FirebaseMessaging.instance.deleteToken();
                  debugPrint("value false delete token");
                }
              });

            },
          )
      ),
    );
  }
}
