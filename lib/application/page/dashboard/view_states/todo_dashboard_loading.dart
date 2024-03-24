import 'package:flutter/material.dart';

class TodoDashboardLoadingPage extends StatelessWidget {
  const TodoDashboardLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
