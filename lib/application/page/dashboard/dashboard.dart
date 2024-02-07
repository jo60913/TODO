import 'package:flutter/material.dart';
import 'package:todo/application/core/page_config.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  static const pageConfig = PageConfig(
      icon: Icons.dashboard_rounded, name: 'dashboard', child: DashBoardPage());

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
