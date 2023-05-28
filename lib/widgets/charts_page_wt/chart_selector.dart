import 'package:expenses/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartSelectorWidget extends StatefulWidget {
  const ChartSelectorWidget({Key? key}) : super(key: key);

  @override
  State<ChartSelectorWidget> createState() => _ChartSelectorWidgetState();
}

class _ChartSelectorWidgetState extends State<ChartSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    final currentChart = context.watch<UIProvider>().selectedChart;
    final uiProvider = context.read<UIProvider>();

    var widgets = <Widget>[];

    Map<String, IconData> typeChart = {
      'Gráfico Lineal': Icons.show_chart_outlined,
      'Gráfico Pai': Icons.pie_chart_outline,
      'Gráfico Dispersión': Icons.bubble_chart_outlined,
    };

    typeChart.forEach((name, icon) {
      widgets.add(GestureDetector(
        onTap: () => setState(() => uiProvider.selectedChart = name),
        child: BubbleTabWidget(
          icon: icon,
          selected: currentChart == name,
        ),
      ));
    });

    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Wrap(
        spacing: 10,
        children: widgets,
      ),
    );
  }
}

class BubbleTabWidget extends StatelessWidget {
  final bool selected;
  final IconData icon;
  const BubbleTabWidget({Key? key, required this.selected, required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Icon(icon, size: 40),
    );
  }
}
