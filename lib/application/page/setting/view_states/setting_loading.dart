import 'package:flutter/material.dart';

class SettingLoading extends StatelessWidget {
  const SettingLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
