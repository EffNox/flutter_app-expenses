import 'package:expenses/pages/add_entries.dart';
import 'package:expenses/pages/add_expenses.dart';
import 'package:expenses/utils/page_animation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.DART';

class CustomFAB extends StatelessWidget {
  const CustomFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SpeedDialChild> childBtns = [
      SpeedDialChild(
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.remove_outlined),
        label: 'Gasto',
        labelStyle: const TextStyle(fontSize: 18.0),
        onTap: () => {
          Navigator.push(
              context, PageAnimationRoute(widget: const AddExpensesPage()))
        },
      ),
      SpeedDialChild(
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.add_outlined),
        label: 'Ingreso',
        labelStyle: const TextStyle(fontSize: 18.0),
        onTap: () => {
          Navigator.push(
              context, PageAnimationRoute(widget: const AddEntriesPage()))
        },
      ),
    ];

    return SpeedDial(
      icon: Icons.add_outlined,
      activeIcon: Icons.close_outlined,
      children: childBtns,
      spacing: 10.0,
      childrenButtonSize: const Size(70, 70),
    );
  }
}
