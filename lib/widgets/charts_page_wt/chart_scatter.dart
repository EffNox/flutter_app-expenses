import 'package:expenses/providers/expenses_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartScatterWidget extends StatelessWidget {
  const ChartScatterWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScatterChart(
      ScatterChartData(
        scatterSpots: _chartSpots(context),
      ),
    );
    // return AspectRatio(
    //   aspectRatio: 0.9,
    //   child: ScatterChart(ScatterChartData(
    //     scatterSpots: _chartSpots(context),
    //   )),
    // );
  }

  List<ScatterSpot> _chartSpots(BuildContext context) {
    final allListItems = context.watch<ExpensesProvider>().allItemsList;

    // dynamic maxExp =allListItems.fold(0.0, (a, b) => a < b.amount ? b.amount : a);
    // for (var e in allListItems) {
    //   debugPrint('e: ${e.day} - ${e.amount} - ${(e.amount / maxExp)}');
    // }
    // debugPrint('maxExp: $maxExp');

    return allListItems
        .map((v) => ScatterSpot(
              v.day.toDouble(),
              v.amount,
              // radius: v.day.toDouble(),
            ))
        .toList();
  }
}
