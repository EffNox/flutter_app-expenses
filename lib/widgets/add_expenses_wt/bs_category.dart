import 'package:expenses/models/combined_model.dart';
import 'package:expenses/providers/entities/db_features.dart';
import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/utils/utils.dart';
import 'package:expenses/widgets/add_expenses_wt/category_list.dart';
import 'package:expenses/widgets/add_expenses_wt/create_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BSCategoryWidget extends StatefulWidget {
  final CombinedModel cModel;

  const BSCategoryWidget({super.key, required this.cModel});

  @override
  State<BSCategoryWidget> createState() => _BSCategoryWidgetState();
}

class _BSCategoryWidgetState extends State<BSCategoryWidget> {
  var catList = CategoryList().catList;
  final DBFeatures fmodel = DBFeatures();
  // final featuresBox = store.box<DBFeatures>();

  @override
  void initState() {
    var exProvider = context.read<ExpensesProvider>();
    if (exProvider.lstFeatures.isEmpty) {
      for (var v in catList) {
        exProvider.upsertFeature(0, v.category, v.color, v.icon);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final lstFeatures = context.watch<ExpensesProvider>().lstFeatures;
    final exProvider = context.watch<ExpensesProvider>();
    bool hasData = (widget.cModel.category != 'Selecciona Categoría');

    return GestureDetector(
      onTap: () => _categorySelected(exProvider.lstFeatures),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Icon(
              hasData ? widget.cModel.icon.toIcon() : Icons.category_outlined,
              color: hasData ? widget.cModel.color.toColor() : Colors.white,
              size: 35,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.7,
                    color: hasData
                        ? widget.cModel.color.toColor()
                        : Theme.of(context).dividerColor,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(child: Text(widget.cModel.category)),
              ),
            )
          ],
        ),
      ),
    );
  }

  _categorySelected(List<DBFeatures> lstFeatures) {
    void itemSelected(String category, String color, String icon, int link) {
      setState(() {
        widget.cModel.link = link;
        widget.cModel.category = category;
        widget.cModel.color = color;
        widget.cModel.icon = icon;
        Navigator.pop(context);
      });
    }

    var widgets = [
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: lstFeatures.length,
        itemBuilder: (_, i) {
          var item = lstFeatures[i];

          return ListTile(
            leading: Icon(
              item.icon.toIcon(),
              color: item.color.toColor(),
              size: 35,
            ),
            title: Text(item.category),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            onTap: () =>
                itemSelected(item.category, item.color, item.icon, item.id),
            onLongPress: () => _editCategory(item),
          );
        },
      ),
      const Divider(thickness: 2),
      ListTile(
        title: const Text('Crear nueva categoría'),
        leading: const Icon(
          Icons.create_new_folder_outlined,
          size: 35,
        ),
        trailing: const Icon(Icons.arrow_forward_ios_outlined),
        onTap: _createCategory,
      ),
      // ListTile(
      //   title: const Text('Administrar una categoría'),
      //   leading: const Icon(
      //     Icons.edit_outlined,
      //     size: 35,
      //   ),
      //   trailing: const Icon(Icons.arrow_forward_ios_outlined),
      //   onTap: _editCategory,
      // )
    ];

    // showBottomSheet(
    showModalBottomSheet(
      // isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: ListView(children: widgets),
      ),
    );
  }

  _createCategory() {
    Navigator.pop(context);
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: false,
      context: context,
      builder: (ctx) => CreateCategoryWidget(model: fmodel),
    );
  }

  _editCategory(DBFeatures v) {
    Navigator.pop(context);
    var modelTemp = DBFeatures(
      id: v.id,
      category: v.category,
      color: v.color,
      icon: v.icon,
    );
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      // builder: (_) => const AdminCategoryWidget(),
      builder: (_) => CreateCategoryWidget(model: modelTemp),
    );
  }
}
