import 'package:flutter/material.dart';

class ToDoOverviewError extends StatelessWidget {
  const ToDoOverviewError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Text('錯誤，請稍後再試'),
    );
  }
}
