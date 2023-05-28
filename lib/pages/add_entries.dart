import 'package:expenses/models/combined_model.dart';
import 'package:expenses/utils/constants.dart';
import 'package:expenses/widgets/add_entries_wt/save_button.dart';
import 'package:expenses/widgets/add_expenses_wt/bs_num_keyboard.dart';
import 'package:expenses/widgets/add_expenses_wt/coment_box.dart';
import 'package:expenses/widgets/add_expenses_wt/date_picker.dart';
import 'package:flutter/material.dart';

class AddEntriesPage extends StatelessWidget {
  const AddEntriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final viewInserts = MediaQuery.of(context).viewInsets.bottom;
    CombinedModel cModel = CombinedModel();
    return Scaffold(
      // REDIMENSIONAR PARA EVITAR EL ERROR
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Agregar ingreso')),
      body: Center(
        child: Column(
          children: [
            BSNumKeyboardWidget(cModel: cModel),
            Expanded(
              child: Container(
                // padding: EdgeInsets.only(bottom: viewInserts),
                width: double.infinity,
                decoration: Constants.sheetBoxDecoration(
                  Theme.of(context).primaryColorDark,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DatePickerWidget(cModel: cModel),
                    // BSCategoryWidget(cModel: cModel),
                    CommentBoxWidget(cModel: cModel),
                    SaveButtonETWidget(cModel: cModel),
                    // Expanded(
                    //   child: Center(child: SaveButtonWidget(cModel: cModel)),
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
