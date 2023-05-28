import 'package:expenses/widgets/charts_page_wt/chart_line.dart';
import 'package:flutter/material.dart';

class FlayerFrecuencyWidget extends StatelessWidget {
  const FlayerFrecuencyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
      child: ChartLineWidget(),
    );
  }
}
