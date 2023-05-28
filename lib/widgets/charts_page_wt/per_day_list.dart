import 'package:expenses/models/combined_model.dart';
import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerDayWidget extends StatelessWidget {
  const PerDayWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final lstExpenses = context.watch<ExpensesProvider>().lstExpense;
    List<CombinedModel> perday = [];

    Map<dynamic, dynamic> perDayMap;

    perDayMap = lstExpenses.fold({}, (Map<dynamic, dynamic> map, exp) {
      map.update(exp.day, (v) => v + exp.expense, ifAbsent: () => exp.expense);
      return map;
    });

    perDayMap.forEach((day, exp) {
      perday.add(CombinedModel(day: day, amount: exp));
    });

    perday.sort((a, b) => b.day.compareTo(a.day));

    return SliverGrid(
      delegate: SliverChildBuilderDelegate((ctx, i) {
        var v = perday[i];
        return GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, 'exp_details', arguments: v.day),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Día'),
                  const Divider(),
                  Text(
                    '${v.day}',
                    style: const TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  const Divider(),
                  Text(getAmountFormat(v.amount)),
                ],
              ),
            ),
          ),
        );
      }, childCount: perday.length),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        // mainAxisSpacing: 12.0,
      ),
    );
  }
}
