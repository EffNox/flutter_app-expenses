import 'package:expenses/pages/balance_page.dart';
import 'package:expenses/pages/charts_page.dart';
import 'package:expenses/pages/settings_page.dart';
import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/providers/ui_provider.dart';
import 'package:expenses/widgets/home_page_wg/customnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePg extends StatelessWidget {
  const HomePg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomNavigationBarWg(),
      body: _GetPageWg(),
    );
  }
}

class _GetPageWg extends StatelessWidget {
  const _GetPageWg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uIProvider = Provider.of<UIProvider>(context);

    // final exProvider = Provider.of<ExpensesProvider>(context, listen: true);
    final exProvider = context.read<ExpensesProvider>();
    final now = DateTime.now();

    final currMonth = uIProvider.selectedMonth + 1;

    switch (uIProvider.bnbIndex) {
      case 0:
        exProvider.getAllFeatures();
        exProvider.getAllExpensesByDate(currMonth, now.year);
        exProvider.getAllEntriesByDate(currMonth, now.year);
        return const BalancePg();
      case 1:
        return const ChartsPg();
      case 2:
        return const SettingsPage();
      default:
        return const Placeholder();
    }
  }
}
