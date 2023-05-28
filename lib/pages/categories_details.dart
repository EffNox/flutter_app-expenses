import 'package:expenses/models/combined_model.dart';
import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/utils/constants.dart';
import 'package:expenses/utils/math_operations.dart';
import 'package:expenses/utils/utils.dart';
import 'package:expenses/widgets/global_wt/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class CategoriesDetailPage extends StatelessWidget {
  const CategoriesDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)!.settings.arguments as CombinedModel;

    var lstCombined = context.watch<ExpensesProvider>().allItemsList;
    var lstExpenses = context.watch<ExpensesProvider>().lstExpense;
    var lstEntries = context.watch<ExpensesProvider>().lstEntry;
    var totalEntries = getAmountFormat(getSumOfEntries(lstEntries));
    var totalExpenses = getAmountFormat(getSumOfExpenses(lstExpenses));

    lstCombined =
        lstCombined.where((e) => e.category == model.category).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            title: Text(model.category),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    getAmountFormat(model.amount),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PercentCircular(
                          percent: getSumOfEntries(lstEntries) / model.amount,
                          radius: 70,
                          color: Colors.blueAccent,
                          arcType: ArcType.HALF,
                        ),
                        Text(
                          'Absorbe de tus\nIngreso: $totalEntries',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PercentCircular(
                          percent: model.amount / getSumOfExpenses(lstExpenses),
                          radius: 70,
                          color: Colors.redAccent,
                          arcType: ArcType.HALF,
                        ),
                        Text(
                          'Representa de tus\nGastos $totalExpenses',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 15),
              height: 40,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                decoration: Constants.sheetBoxDecoration(
                  Theme.of(context).primaryColorDark,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              var v = lstCombined[index];
              return ListTile(
                leading: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    const Icon(Icons.calendar_today, size: 40),
                    Positioned(
                      top: 13,
                      child: Text(
                        '${v.day}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    )
                  ],
                ),
                title: PercentLinearWidget(
                  percent: v.amount / model.amount,
                  color: v.color.toColor(),
                ),
                trailing: Text(
                  getAmountFormat(v.amount),
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }, childCount: lstCombined.length),
          )
        ],
      ),
    );
  }
}
