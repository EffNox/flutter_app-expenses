import 'package:expenses/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavigationBarWg extends StatelessWidget {
  const CustomNavigationBarWg({super.key});

  @override
  Widget build(BuildContext context) {
    final uIProvider = Provider.of<UIProvider>(context);

    // final watchIndex = context.watch<UIProvider>();
    // final read = context.read<UIProvider>();

    return BottomNavigationBar(
        currentIndex: uIProvider.bnbIndex,
        onTap: (int i) => uIProvider.bnbIndex = i,
        items: const [
          BottomNavigationBarItem(
            label: 'Balance',
            icon: Icon(Icons.account_balance_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Gráficos',
            icon: Icon(Icons.bar_chart_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Configuración',
            icon: Icon(Icons.settings_outlined),
          ),
        ]);
  }
}
