import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/utils/math_operations.dart';
import 'package:expenses/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerCategoryListWidget extends StatelessWidget {
  const PerCategoryListWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final lstGroup = context.watch<ExpensesProvider>().groupItemsList;

    return SliverList(
      delegate: SliverChildBuilderDelegate((ctx, i) {
        var v = lstGroup[i];
        return ListTile(
          leading: Icon(v.icon.toIcon(), color: v.color.toColor(), size: 40),
          title: Text(v.category),
          trailing: Text(getAmountFormat(v.amount)),
          onTap: () =>
              Navigator.pushNamed(context, 'category_details', arguments: v),
        );
      }, childCount: lstGroup.length),
    );
  }
}
