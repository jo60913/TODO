import 'package:flutter/material.dart';
import 'package:todo/application/core/page_config.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({super.key});
  static const pageConfig = PageConfig(
      icon: Icons.work_history_rounded, name: 'overview', child: OverViewPage());
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
