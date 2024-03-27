import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:todo/domain/entity/todo_collection_and_entry.dart';

import '../../../../resource/app_color.dart';

class ToDoDashBoardLoadedPage extends StatelessWidget {
  final List<ToDoCollectionAndEntry> collections;
  late List<MapEntry<String, double>> collectionSuccess;
  ToDoDashBoardLoadedPage({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    final list = collections.expand((e) => e.entryList).toList();
    int successCount = list.where((element) => (element.isDone == true)).length;
    collectionSuccess = collections.map((element) {
      if(element.entryList.isEmpty) {
        return MapEntry(element.title, 0.0);
      }
      final rate = (element.entryList.where((todoEntry) => todoEntry.isDone == true).length / element.entryList.length).toDouble() * 100;
      return MapEntry(element.title, rate);}).toList();
    int itemCount = list.length;
    const Duration animDuration = Duration(milliseconds: 250);
    double successRate = successCount / itemCount;
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('完成率 ${(successRate*100).round()} %'),
      const SizedBox(height: 50,),
      Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: BarChart(
              BarChartData(
                barGroups: _getBarChar(collectionSuccess),
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: getTitles,
                      reservedSize: 38,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: getLeftTitle
                    ),
                  ),
                ),
              ),
              swapAnimationDuration: animDuration,
            ),
          ))
    ]);
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text = Text(collectionSuccess.elementAt((value-1).toInt()).key, style: style);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  List<BarChartGroupData> _getBarChar(
      List<MapEntry<String, double>> list) {
    int index = 0;
    final bar = list.map((element) {
      index++;
      return makeGroupData(index,element.value);
    });
    return bar.toList();
  }

  BarChartGroupData makeGroupData(
      int x,
      double y,
      ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppColors.contentColorOrange,
          width: 22,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: y,
            color: AppColors.contentColorOrange,
          ),
        ),
      ],
    );
  }

  Widget getLeftTitle(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      child: Text(
        meta.formattedValue,
      ),
    );
  }
}
