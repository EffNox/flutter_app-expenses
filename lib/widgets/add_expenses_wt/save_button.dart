import 'package:expenses/models/combined_model.dart';
import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SaveButtonWidget extends StatelessWidget {
  final CombinedModel cModel;
  const SaveButtonWidget({Key? key, required this.cModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();
    // final uiProvider = context.read<UIProvider>();

    return GestureDetector(
      child: SizedBox(
        height: 80,
        width: 150,
        child: Constants.customButton(
            cModel.id != 0 ? Colors.blueAccent : Colors.green,
            Colors.white,
            cModel.id != 0 ? 'Actualizar' : 'Guardar'),
      ),
      onTap: () {
        if (cModel.amount != 0.00) {
          exProvider.upsertExpense(cModel);
          Fluttertoast.showToast(msg: 'Se guardo');
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(msg: 'No se guardo');
        }
        // uiProvider.bnbIndex = 0;
      },
    );
  }
}
