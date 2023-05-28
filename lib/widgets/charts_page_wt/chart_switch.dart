import 'package:expenses/providers/ui_provider.dart';
import 'package:expenses/widgets/charts_page_wt/chart_line.dart';
import 'package:expenses/widgets/charts_page_wt/chart_pie.dart';
import 'package:expenses/widgets/charts_page_wt/chart_scatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartSwitchWidget extends StatelessWidget {
  const ChartSwitchWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentChart = context.watch<UIProvider>().selectedChart;
    switch (currentChart) {
      case 'Gráfico Lineal':
        return const ChartLineWidget();
      case 'Gráfico Pai':
        return const ChartPieWidget();
      case 'Gráfico Dispersión':
        return const ChartScatterWidget();
      default:
        return const ChartLineWidget();
    }
  }
}
