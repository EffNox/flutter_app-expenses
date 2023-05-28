import 'package:expenses/providers/entities/db_features.dart';
import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/utils/utils.dart';
import 'package:expenses/widgets/add_expenses_wt/create_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminCategoryWidget extends StatelessWidget {
  const AdminCategoryWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final features = context.watch<ExpensesProvider>().lstFeatures;
    return ListView.builder(
      itemCount: features.length,
      itemBuilder: (ctx, i) {
        var v = features[i];

        return ListTile(
          title: Text(v.category),
          leading: Icon(v.icon.toIcon(), size: 35, color: v.color.toColor()),
          trailing: const Icon(Icons.edit_outlined, size: 25),
          onTap: () => {Navigator.pop(context), createCategory(context, v)},
        );
      },
    );
  }

  createCategory(BuildContext ctx, DBFeatures model) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => CreateCategoryWidget(model: model),
    );
  }
}
