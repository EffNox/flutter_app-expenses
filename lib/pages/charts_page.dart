import 'package:expenses/providers/ui_provider.dart';
import 'package:expenses/utils/constants.dart';
import 'package:expenses/widgets/charts_page_wt/chart_selector.dart';
import 'package:expenses/widgets/charts_page_wt/chart_switch.dart';
import 'package:expenses/widgets/charts_page_wt/per_cat_list.dart';
import 'package:expenses/widgets/charts_page_wt/per_day_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartsPg extends StatelessWidget {
  const ChartsPg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentChart = context.watch<UIProvider>().selectedChart;
    bool isPerDay = (currentChart == 'Gráfico Lineal' ||
        currentChart == 'Gráfico Dispersión');

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(title: Text(currentChart), centerTitle: true),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 350,
            // expandedHeight: 800,
            flexibleSpace: FlexibleSpaceBar(
              background: Align(
                // alignment: Alignment.bottomCenter,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    ChartSelectorWidget(),
                    Expanded(
                      child: ChartSwitchWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            // child: ChartLineWidget(),
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              height: 40,
              color: const Color(0xff121212),
              child: Container(
                decoration: Constants.sheetBoxDecoration(
                  Theme.of(context).primaryColorDark,
                ),
              ),
            ),
          ),
          (isPerDay) ? const PerDayWidget() : const PerCategoryListWidget()
        ],
      ),
    );
  }
}
