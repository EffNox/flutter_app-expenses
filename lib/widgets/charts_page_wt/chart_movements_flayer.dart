import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/utils/math_operations.dart';
import 'package:expenses/widgets/global_wt/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class FlayerMovementsWidget extends StatelessWidget {
  const FlayerMovementsWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final lstExpenses = context.watch<ExpensesProvider>().lstExpense;
    final lstEntries = context.watch<ExpensesProvider>().lstEntry;
    double totExpense = 0;
    double totEntry = 0;

    totExpense = getSumOfExpenses(lstExpenses);
    totEntry = getSumOfEntries(lstEntries);

    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: PercentCircular(
              percent: totExpense / totEntry,
              radius: 100.0,
              color: Colors.green,
              arcType: ArcType.FULL,
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gastos Realizados',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    getAmountFormat(totExpense),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 1.3,
                    ),
                  ),
                  Text(
                    'Absorbe un ${(totExpense / totEntry * 100).toStringAsFixed(2)}% de tus ingresos',
                    style: const TextStyle(
                        // fontWeight: FontWeight.bold,
                        // fontSize: 20,
                        // letterSpacing: 1.3,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
