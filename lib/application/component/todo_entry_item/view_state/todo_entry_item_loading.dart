import 'package:flutter/material.dart';

class ToDoEntryItemLoading extends StatelessWidget {
  const ToDoEntryItemLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
