// ignore_for_file: depend_on_referenced_packages

import 'package:expenses/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

late final Store store;

class ObjectBoxDB {
  /// The Store of this app.
  // late final Store store;
  // late final Store _store;

  // ObjectBox._create(this.store) {
  //   // Add any additional setup code, e.g. build queries.
  // }

  // static Future<ObjectBox> create() async {
  //   final docsDir = await getApplicationDocumentsDirectory();
  //   final store =await openStore(directory: p.join(docsDir.path, "obx-effnox"),);
  //   return ObjectBox._create(store);
  // }

  Future<void> initStore() async {
    final docsDir = await getApplicationDocumentsDirectory();

    store = await openStore(directory: p.join(docsDir.path, "objx-effnox"));
  }

  // Store get store => _store;
}
