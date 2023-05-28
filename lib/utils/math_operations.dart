// ignore: depend_on_referenced_packages
import 'package:expenses/providers/entities/entity_expenses.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

// export 'package:expenses/utils/math_operations.dart';

getAmountFormat(double amount) =>
    NumberFormat.simpleCurrency(name: 'PEN').format(amount);

getSumOfExpenses(List<EntityExpense> lst) =>
    lst.fold(0.0, (a, b) => a + b.expense);

getSumOfEntries(List<EntityEntry> lst) => lst.fold(0.0, (a, b) => a + b.entry);

getBalance(List<EntityExpense> lstExpense, List<EntityEntry> lstEnry) =>
    getSumOfEntries(lstEnry) + getSumOfExpenses(lstExpense);
