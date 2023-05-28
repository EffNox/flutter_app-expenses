import 'package:objectbox/objectbox.dart';

@Entity()
class EntityExpense {
  int id;
  int link;
  int year;
  int month;
  int day;
  String comment;
  double expense;

  EntityExpense({
    this.id = 0,
    this.link = 0,
    this.year = 0,
    this.month = 0,
    this.day = 0,
    this.comment = '',
    this.expense = 0,
  });
}

@Entity()
class EntityEntry {
  int id;
  int year;
  int month;
  int day;
  String comment;
  double entry;

  EntityEntry({
    this.id = 0,
    this.year = 0,
    this.month = 0,
    this.day = 0,
    this.comment = '',
    this.entry = 0,
  });
}
