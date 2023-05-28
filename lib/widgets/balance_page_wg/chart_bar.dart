import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/utils/math_operations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartBarWidget extends StatelessWidget {
  const ChartBarWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final lstExpenses = context.watch<ExpensesProvider>().lstExpense;
    final lstEntries = context.watch<ExpensesProvider>().lstEntry;
    double totExpenses = 0;
    double totEntries = 0;

    totExpenses = getSumOfExpenses(lstExpenses);
    totEntries = getSumOfEntries(lstEntries);

    return BarChart(
      BarChartData(
        barGroups: chartData(totEntries, totExpenses),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta titleMeta) {
                switch (value.toInt()) {
                  case 1:
                    return const Text('Ingresos');
                  case 2:
                    return const Text('Egresos');
                  default:
                    return const Text('');
                }
              },
            ),
          ),
        ),
      ),
      swapAnimationDuration: const Duration(seconds: 1), // Optional
    );
  }

  List<BarChartGroupData> chartData(double totEntries, double totExpenses) {
    return [
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(toY: totEntries),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(toY: totExpenses),
        ],
      ),
    ];
  }
  // List<BarChartGroupData> chartData(List<EntityExpense> lst) {
  //   return lst
  //       .map(
  //         (e) => BarChartGroupData(
  //           x: e.day,
  //           barRods: [
  //             BarChartRodData(toY: e.expense),
  //           ],
  //         ),
  //       )
  //       .toList();
  // }
}
