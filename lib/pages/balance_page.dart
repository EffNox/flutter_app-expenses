import 'dart:math';

import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/utils/math_operations.dart';
import 'package:expenses/widgets/balance_page_wg/back_sheet.dart';
import 'package:expenses/widgets/balance_page_wg/custom_fab.dart';
import 'package:expenses/widgets/balance_page_wg/front_sheet.dart';
import 'package:expenses/widgets/balance_page_wg/month_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalancePg extends StatefulWidget {
  const BalancePg({Key? key}) : super(key: key);

  @override
  State<BalancePg> createState() => _BalancePgState();
}

class _BalancePgState extends State<BalancePg> {
  final _scrollController = ScrollController();
  double _offset = 0;

  void _listener() {
    setState(() {
      _offset = _scrollController.offset / 100;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_listener);
    _max;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }

  double get _max => max(90 - _offset * 90, 00);

  @override
  Widget build(BuildContext context) {
    final lstExpenses = context.watch<ExpensesProvider>().lstExpense;
    final lstEntries = context.watch<ExpensesProvider>().lstEntry;

    return Scaffold(
      floatingActionButton: const CustomFAB(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 110.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const MonthSelectorWidget(),
                  Text(
                    '${getAmountFormat(getBalance(lstExpenses, lstEntries))}',
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.green,
                    ),
                  ),
                  const Text('Balance', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Stack(
                  children: [
                    const BackSheetWg(),
                    Padding(
                      padding: EdgeInsets.only(top: _max),
                      child: const FrontSheetWg(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
