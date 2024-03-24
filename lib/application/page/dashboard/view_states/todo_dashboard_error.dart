import 'package:flutter/material.dart';

class TodoDashboardErrorPage extends StatelessWidget {
  const TodoDashboardErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      onTap: null,
      leading: Icon(Icons.warning_rounded),
      title: Text('找不到該選項'),
    );
  }
}
