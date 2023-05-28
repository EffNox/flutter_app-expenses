import 'package:expenses/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntriesDetailPage extends StatelessWidget {
  const EntriesDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lstEntries = context.watch<ExpensesProvider>().lstEntry;
    return Scaffold(
      appBar: AppBar(title: const Text('Desglose de ingresos')),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (ctx, i) {
              var v = lstEntries[i];

              return ListTile(
                title: Text(v.entry.toString()),
              );
            },
            childCount: lstEntries.length,
          ))
        ],
      ),
    );
  }
}
