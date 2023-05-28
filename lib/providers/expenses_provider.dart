import 'package:expenses/models/combined_model.dart';
import 'package:expenses/objectbox.g.dart';
import 'package:expenses/providers/entities/db_features.dart';
import 'package:expenses/providers/entities/entity_expenses.dart';
import 'package:expenses/utils/objectbox_db.dart';
import 'package:flutter/material.dart';

class ExpensesProvider extends ChangeNotifier {
  List<DBFeatures> lstFeatures = [];
  List<EntityExpense> lstExpense = [];
  List<EntityEntry> lstEntry = [];
  List<CombinedModel> lstCombined = [];

  final featuresBox = store.box<DBFeatures>();
  final expenseBox = store.box<EntityExpense>();
  final entryBox = store.box<EntityEntry>();

  upsertFeature(id, category, color, icon) {
    var model =
        DBFeatures(id: id, category: category, color: color, icon: icon);
    var dbId = featuresBox.put(model);
    // debugPrint('Feature ${id == 0 ? 'creado' : 'actualizado $id'}');
    model.id = dbId;
    if (id == 0) lstFeatures.add(model);
    notifyListeners();
  }

  getAllFeatures() async {
    final rs = await featuresBox.getAllAsync();
    lstFeatures = [...rs];
    notifyListeners();
  }

  /* Expenses & Entries */

  getAllExpensesByDate(int month, int year) async {
    // debugPrint('year: $year');
    // debugPrint('month: $month');
    final rs = expenseBox
        .query(EntityExpense_.month.equals(month) &
            EntityExpense_.year.equals(year))
        .build()
        .find();

    lstExpense = [...rs];
    // final rs = await expenseBox.getAllAsync()/* .whenComplete(() => null) */;
    // notifyListeners();
  }

  upsertExpense(CombinedModel cModel) {
    // debugPrint('EXPENSE ${cModel.id != 0 ? 'create' : 'update'} ${cModel.id}');
    var model = EntityExpense(
      id: cModel.id,
      link: cModel.link!,
      year: cModel.year,
      month: cModel.month,
      day: cModel.day,
      comment: cModel.comment,
      expense: cModel.amount,
    );
    var dbId = expenseBox.put(model);
    model.id = dbId;
    // debugPrint('cModel.id: ${cModel.id}');
    if (model.id == 0) lstExpense.add(model);
    notifyListeners();
  }

  deleteExpense(int id) async => expenseBox.remove(id);

  List<CombinedModel> get allItemsList {
    var cModelTmpS = lstExpense
        .map((x) => lstFeatures.where((y) => x.link == y.id).map(
              (y) => CombinedModel(
                category: y.category,
                color: y.color,
                icon: y.icon,
                id: x.id,
                link: x.link,
                comment: x.comment,
                amount: x.expense,
                year: x.year,
                month: x.month,
                day: x.day,
              ),
            ))
        .map((e) => e.first);

    lstCombined = [...cModelTmpS];
    return lstCombined;
  }

  List<CombinedModel> get groupItemsList {
    final uniqueModel = lstFeatures
        .where((y) => lstExpense.any((x) => x.link == y.id))
        .map((y) => CombinedModel(
              category: y.category,
              color: y.color,
              icon: y.icon,
              amount: lstExpense
                  .where((x) => x.link == y.id)
                  .fold(0.0, (a, c) => a + c.expense),
            ));

    return lstCombined = [...uniqueModel];
  }

  getAllEntriesByDate(int month, int year) async {
    final rs = entryBox
        .query(
            EntityEntry_.month.equals(month) & EntityEntry_.year.equals(year))
        .build()
        .find();

    // rs.find().forEach((element) {
    //   debugPrint('${element.id} ${element.comment}');
    // });
    lstEntry = [...rs];
    // final rs = await expenseBox.getAllAsync()/* .whenComplete(() => null) */;
  }

  upsertEntry(CombinedModel cModel) {
    var model = EntityEntry(
      id: 0,
      year: cModel.year,
      month: cModel.month,
      day: cModel.day,
      comment: cModel.comment,
      entry: cModel.amount,
    );
    var dbId = entryBox.put(model);
    debugPrint('Entry ${model.id == 0 ? 'create' : 'update'} ${model.id}');
    model.id = dbId;
    if (cModel.id == 0) lstEntry.add(model);
    notifyListeners();
  }

  deleteEntry(int id) async {
    expenseBox.remove(id);
  }
}
