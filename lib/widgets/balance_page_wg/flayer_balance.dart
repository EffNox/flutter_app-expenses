import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/utils/math_operations.dart';
import 'package:expenses/widgets/balance_page_wg/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlayerBalanceWidget extends StatelessWidget {
  const FlayerBalanceWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final lstExpenses = context.watch<ExpensesProvider>().lstExpense;
    final lstEntries = context.watch<ExpensesProvider>().lstEntry;
    double totExpenses = 0;
    double totEntries = 0;
    double total = 0;

    totExpenses = getSumOfExpenses(lstExpenses);
    totEntries = getSumOfEntries(lstEntries);
    // total = getBalance(lstExpenses, lstEntries);
    total = (totEntries - totExpenses);

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                title: const Text(
                  'Ingresos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Text(
                  getAmountFormat(totEntries),
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                title: const Text(
                  'Gastos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Text(
                  getAmountFormat(totExpenses),
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const Divider(
                indent: 15,
                endIndent: 15,
                thickness: 2.0,
              ),
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                title: const Text(
                  'Balance',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Text(
                  getAmountFormat(total),
                  style: TextStyle(
                    color: total < 0 ? Colors.redAccent : Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const SizedBox(
                height: 200,
                child: ChartBarWidget(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
