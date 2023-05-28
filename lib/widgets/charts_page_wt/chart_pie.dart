import 'package:expenses/models/combined_model.dart';
import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartPieWidget extends StatelessWidget {
  const ChartPieWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final groupItemList = context.watch<ExpensesProvider>().groupItemsList;

    return PieChart(
      PieChartData(
        sections: _chartSections(groupItemList),
      ),
    );
    // return AspectRatio(
    //   aspectRatio: 0.9,
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 50),
    //     child: PieChart(
    //       PieChartData(
    //         sections: _chartSections(groupItemList),
    //       ),
    //     ),
    //   ),
    // );
  }

  List<PieChartSectionData> _chartSections(List<CombinedModel> data) {
    return data
        .map((v) => PieChartSectionData(
              radius: 80.0,
              color: v.color.toColor(),
              value: v.amount,
              title: v.category.toString(),
              badgeWidget: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(v.icon.toIcon(), size: 14),
                  const SizedBox(width: 5),
                  Text(
                    v.amount.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              titlePositionPercentageOffset: 1.27,
              titleStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ))
        .toList();
  }
}
