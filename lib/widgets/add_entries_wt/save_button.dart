import 'package:expenses/models/combined_model.dart';
import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SaveButtonETWidget extends StatelessWidget {
  final CombinedModel cModel;
  const SaveButtonETWidget({Key? key, required this.cModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();

    return GestureDetector(
      child: SizedBox(
        height: 80,
        width: 150,
        child: Constants.customButton(Colors.green, Colors.white, 'Guardar'),
      ),
      onTap: () {
        if (cModel.amount != 0.00) {
          exProvider.upsertEntry(cModel);
          Fluttertoast.showToast(msg: 'Se guardo');
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(msg: 'No se guardo');
        }
      },
    );
  }
}
