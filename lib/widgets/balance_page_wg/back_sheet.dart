import 'package:expenses/pages/entries_details.dart';
import 'package:expenses/pages/expenses_details.dart';
import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/utils/constants.dart';
import 'package:expenses/utils/math_operations.dart';
import 'package:expenses/utils/page_animation_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BackSheetWg extends StatelessWidget {
  const BackSheetWg({super.key});

  @override
  Widget build(BuildContext context) {
    final lstExpenses = context.watch<ExpensesProvider>().lstExpense;
    final lstEntries = context.watch<ExpensesProvider>().lstEntry;

    headers(String name, String amount, Color color) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13, bottom: 5),
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                letterSpacing: 1.5,
              ),
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 1.5,
              color: color,
            ),
          )
        ],
      );
    }

    return Container(
      height: 250.0,
      decoration:
          Constants.sheetBoxDecoration(Theme.of(context).primaryColorDark),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            child: headers('Ingresos',
                getAmountFormat(getSumOfEntries(lstEntries)), Colors.green),
            onTap: () => Navigator.push(
              context,
              PageAnimationRoute(widget: const EntriesDetailPage()),
            ),
          ),
          const VerticalDivider(thickness: 2.0),
          GestureDetector(
            child: headers(
              'Gastos',
              getAmountFormat(getSumOfExpenses(lstExpenses)),
              Colors.red,
            ),
            onTap: () => Navigator.push(
              context,
              PageAnimationRoute(widget: const ExpensesDetailPage()),
            ),
          )
        ],
      ),
    );
  }
}
