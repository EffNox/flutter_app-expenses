import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/utils/constants.dart';
import 'package:expenses/widgets/balance_page_wg/flayer_balance.dart';
import 'package:expenses/widgets/balance_page_wg/flayer_categories.dart';
import 'package:expenses/widgets/balance_page_wg/flayer_skin.dart';
import 'package:expenses/widgets/charts_page_wt/chart_frecuency_flayer.dart';
import 'package:expenses/widgets/charts_page_wt/chart_movements_flayer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FrontSheetWg extends StatelessWidget {
  const FrontSheetWg({super.key});

  @override
  Widget build(BuildContext context) {
    final lstExpenses = context.watch<ExpensesProvider>().lstExpense;

    bool hasData = false;

    if (lstExpenses.isNotEmpty) {
      hasData = true;
    }

    // var list = List.generate(
    //   10,
    //   (i) => Padding(
    //     padding: const EdgeInsets.all(10),
    //     child: Container(
    //       height: 150,
    //       decoration: BoxDecoration(
    //         color: Theme.of(context).primaryColorDark,
    //         borderRadius: BorderRadius.circular(30),
    //       ),
    //     ),
    //   ),
    // );

    return Container(
      // height: 850.0,
      decoration: Constants.sheetBoxDecoration(
        Theme.of(context).scaffoldBackgroundColor,
      ),
      child: hasData
          ? ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const FlayerSkinWidget(
                  title: 'Categoría de gastos',
                  widget: FlayerCategoriesWidget(),
                ),
                const FlayerSkinWidget(
                  title: 'Frecuencia de gastos',
                  widget: FlayerFrecuencyWidget(),
                ),
                const FlayerSkinWidget(
                  title: 'Movimientos',
                  widget: FlayerMovementsWidget(),
                ),
                const FlayerSkinWidget(
                  title: 'Balance general',
                  widget: FlayerBalanceWidget(),
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: Image.asset('assets/empty.png'),
                )
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(50),
                  child: Image.asset('assets/empty.png'),
                ),
                const Text(
                  'No tiene gastos este mes, agrega aquí 🤙',
                  maxLines: 1,
                  style: TextStyle(fontSize: 15, letterSpacing: 1.3),
                )
              ],
            ),
    );
  }
}
