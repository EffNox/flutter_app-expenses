import 'package:expenses/providers/entities/db_features.dart';
import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/utils/constants.dart';
import 'package:expenses/utils/icon_list.dart';
import 'package:expenses/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CreateCategoryWidget extends StatefulWidget {
  final DBFeatures model;

  const CreateCategoryWidget({Key? key, required this.model}) : super(key: key);

  @override
  State<CreateCategoryWidget> createState() => _CreateCategoryWidgetState();
}

class _CreateCategoryWidgetState extends State<CreateCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final lstFeatures = context.watch<ExpensesProvider>().lstFeatures;
    final expensesProvider = context.read<ExpensesProvider>();

    // INFO Obtener el tamaño del teclado o lo que se eleve y ajustar a la pantalla para que se visualice
    final viewInserts = MediaQuery.of(context).viewInsets.bottom;

    // Iterable<FeaturesModel> contain = lstFeatures
    //     .where((e) => e.category.containsIgnoreCase(widget.model.category))
    //     .cast();

    bool exists = lstFeatures
        .map((e) => e.category)
        .containsIgnoreCase(widget.model.category);

    void addCategory() {
      if (exists) {
        Fluttertoast.showToast(msg: 'Ya existe la categoría ingresada');
      } else if (widget.model.category.isNotEmpty) {
        expensesProvider.upsertFeature(widget.model.id, widget.model.category,
            widget.model.color, widget.model.icon);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: 'No olvides nombrar una categoría');
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: viewInserts),
              child: ListTile(
                trailing: const Icon(Icons.text_fields_outlined),
                title: TextFormField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  initialValue: widget.model.category,
                  decoration: InputDecoration(
                    hintText: 'Digite categoría',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (value) {
                    widget.model.category = value;
                  },
                ),
              ),
            ),
            ListTile(
              onTap: selectColor,
              trailing: CircleColor(
                color: widget.model.color.toColor(),
                // color: Colors.red,
                circleSize: 35,
              ),
              title: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).cardColor),
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(child: Text('Color ')),
              ),
            ),
            ListTile(
              onTap: selectIcon,
              trailing: Icon(widget.model.icon.toIcon(), size: 35),
              title: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).cardColor),
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(child: Text('Icon ')),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Constants.customButton(
                      Colors.transparent,
                      Colors.redAccent,
                      'Cancelar',
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Constants.customButton(
                      widget.model.id > 0 ? Colors.blueGrey : Colors.green,
                      Colors.transparent,
                      widget.model.id > 0 ? 'Actualizar' : 'Registrar',
                    ),
                    onTap: addCategory,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  selectColor() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MaterialColorPicker(
            selectedColor: widget.model.color.toColor(),
            physics: const NeverScrollableScrollPhysics(),
            circleSize: 35,
            // colors: fullMaterialColors,
            // allowShades: false,
            onColorChange: (color) {
              var hexColor =
                  '#${color.value.toRadixString(16).substring(2, 8)}';
              setState(() => widget.model.color = hexColor);
            },
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Constants.customButton(
              Colors.green,
              Colors.transparent,
              'Aceptar',
            ),
          )
        ],
      ),
    );
  }

  selectIcon() {
    final icons = IconList().iconMap;
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      // isScrollControlled: true,
      builder: (_) => SizedBox(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5),
          itemCount: icons.length,
          itemBuilder: (_, i) {
            var key = icons.keys.elementAt(i);
            return GestureDetector(
              child: Icon(
                key.toIcon(),
                size: 30,
                color: Theme.of(context).dividerColor,
              ),
              onTap: () => setState(() {
                widget.model.icon = key;
                Navigator.pop(context);
              }),
            );
          },
        ),
      ),
    );
  }
}
