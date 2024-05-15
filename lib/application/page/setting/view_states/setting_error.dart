import 'package:flutter/material.dart';

class SettingError extends StatelessWidget {
  const SettingError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Text("網路錯誤，請稍後再試。"),
    );
  }
}
