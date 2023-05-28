import 'package:objectbox/objectbox.dart';

@Entity()
class DBFeatures {
  int id;
  String color;
  String category;
  String icon;

  DBFeatures({
    this.id = 0,
    this.category = '',
    this.color = '#e05e48',
    this.icon = 'adb_rounded',
  });
}
