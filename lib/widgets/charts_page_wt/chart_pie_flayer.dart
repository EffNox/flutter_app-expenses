import 'package:expenses/models/combined_model.dart';
import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartPieFlayerWidget extends StatelessWidget {
  const ChartPieFlayerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final groupItemList = context.watch<ExpensesProvider>().groupItemsList;

    return PieChart(
      PieChartData(
        sections: _chartSections(groupItemList),
        sectionsSpace: 4,
        centerSpaceRadius: 20,
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            if (!event.isInterestedForInteractions ||
                pieTouchResponse == null ||
                pieTouchResponse.touchedSection == null) return;

            var touchedIndex =
                pieTouchResponse.touchedSection!.touchedSectionIndex;

            final touchedValue = groupItemList[touchedIndex];
            debugPrint(
                'touchedValue: ${touchedValue.category} ${touchedValue.amount}');
          },
        ),
      ),
      // swapAnimationCurve: Curves.elasticIn,
      swapAnimationDuration: const Duration(seconds: 1),
    );
  }

  List<PieChartSectionData> _chartSections(List<CombinedModel> data) {
    return data
        .map((v) => PieChartSectionData(
              radius: 100.0,
              color: v.color.toColor(),
              badgeWidget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    v.category,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(v.icon.toIcon(), size: 10),
                      Text(
                        v.amount.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ))
        .toList();
  }
}
