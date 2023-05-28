import 'package:expenses/models/combined_model.dart';
import 'package:expenses/utils/constants.dart';
import 'package:expenses/widgets/add_expenses_wt/bs_category.dart';
import 'package:expenses/widgets/add_expenses_wt/bs_num_keyboard.dart';
import 'package:expenses/widgets/add_expenses_wt/coment_box.dart';
import 'package:expenses/widgets/add_expenses_wt/date_picker.dart';
import 'package:expenses/widgets/add_expenses_wt/save_button.dart';
import 'package:flutter/material.dart';

class AddExpensesPage extends StatelessWidget {
  const AddExpensesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    CombinedModel cModel = CombinedModel();
    final editCmodel =
        ModalRoute.of(context)!.settings.arguments as CombinedModel?;
    bool hasData = false;

    if (editCmodel != null) {
      cModel = editCmodel;
      hasData = true;
    }

    return Scaffold(
      // REDIMENSIONAR PARA EVITAR EL ERROR
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(hasData ? 'Editar gasto' : 'Agregar gasto')),
      body: Center(
        child: Column(
          children: [
            BSNumKeyboardWidget(cModel: cModel),
            Expanded(
              child: Container(
                // padding: EdgeInsets.only(bottom: viewInsets),
                width: double.infinity,
                decoration: Constants.sheetBoxDecoration(
                  Theme.of(context).primaryColorDark,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DatePickerWidget(cModel: cModel),
                      BSCategoryWidget(cModel: cModel),
                      Container(
                        padding: EdgeInsets.only(top: viewInsets),
                        child: CommentBoxWidget(cModel: cModel),
                      ),
                      SaveButtonWidget(cModel: cModel)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
