import 'package:expenses/providers/expenses_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartLineWidget extends StatelessWidget {
  const ChartLineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charLine(context);
    // return SizedBox(
    //   child: Container(
    //     constraints: const BoxConstraints(
    //       maxHeight: 330.0,
    //       maxWidth: double.infinity,
    //     ),
    //     child: charLine(context),
    //   ),
    // );
  }

  LineChart charLine(BuildContext context) {
    final lstExpense = context.watch<ExpensesProvider>().lstExpense;
    // final currentMonth = context.watch<UIProvider>().selectedMonth;
    // var monthDays = daysInMonth(currentMonth + 1);

    lstExpense.sort((a, b) => a.day.compareTo(b.day));

    var maxExp = lstExpense
        .fold<Map<int, double>>({}, (map, exp) {
          // if (!map.containsKey(exp.day)) map[exp.day] = 0.0;
          // map[exp.day] += exp.expense;

          map.update(exp.day, (sum) => sum + exp.expense,
              ifAbsent: () => exp.expense);
          return map;
        })
        .entries
        .map((e) => FlSpot(e.key.toDouble(), e.value))
        .toList();

    return LineChart(
      swapAnimationCurve: Curves.slowMiddle,
      swapAnimationDuration: const Duration(seconds: 1),
      LineChartData(lineBarsData: [
        LineChartBarData(
          spots: maxExp,
          // belowBarData: BarAreaData(show: true),
        )
      ]),
    );
  }
}
