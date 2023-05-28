import 'package:expenses/models/combined_model.dart';
import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/providers/ui_provider.dart';
import 'package:expenses/utils/math_operations.dart';
import 'package:expenses/utils/utils.dart';
import 'package:expenses/widgets/charts_page_wt/chart_pie_flayer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlayerCategoriesWidget extends StatelessWidget {
  const FlayerCategoriesWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final expensesProvider = context.watch<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();
    var gList = expensesProvider.groupItemsList;

    if (gList.length >= 6) {
      gList = gList.sublist(0, 5);
      gList.add(CombinedModel(
        category: 'Otros...',
        icon: 'otros',
        color: '#20624a',
      ));
    }

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: gList.length,
            itemBuilder: (_, i) {
              var v = gList[i];

              return GestureDetector(
                onTap: () {
                  if (v.category == 'Otros...') {
                    uiProvider.bnbIndex = 1;
                    uiProvider.selectedChart = 'Gráfico Pai';
                  } else {
                    Navigator.pushNamed(
                      context,
                      'category_details',
                      arguments: v,
                    );
                  }
                },
                child: ListTile(
                  dense: true,
                  // Encoger verticalmente los items
                  visualDensity: const VisualDensity(vertical: -4),
                  // leading y title más juntos
                  horizontalTitleGap: 5,
                  leading: Icon(v.icon.toIcon(), color: v.color.toColor()),
                  title: Text(
                    v.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(getAmountFormat(v.amount)),
                ),
              );
            },
          ),
        ),
        const Expanded(
          flex: 2,
          // child: CircleColor(color: Colors.green, circleSize: 200),
          child: SizedBox(
            height: 200,
            width: 200,
            child: ChartPieFlayerWidget(),
          ),
        )
      ],
    );
  }
}
