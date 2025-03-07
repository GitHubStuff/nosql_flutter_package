import 'dart:async' show FutureOr;
import 'package:hive_ce/hive.dart' show Hive;
import 'package:nosql_flutter_package/src/nosql_abstract.dart'
    show NoSqlBox, NoSqlDB;
import 'package:nosql_flutter_package/src/nosql_hive_box.dart'
    show NoSqlHiveBox;

class NoSqlHive implements NoSqlDB {
  @override
  FutureOr<bool> init({String subDir = 'nosql_hive'}) async {
    try {
      Hive.init(subDir);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  FutureOr<bool> deleteFromDevice() async {
    try {
      await Hive.deleteFromDisk();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  FutureOr<NoSqlBox<T>?> openBox<T>(String boxName) async {
    try {
      final box = await Hive.openBox<T>(boxName);
      return NoSqlHiveBox<T>(box);
    } on Exception catch (_) {
      return null;
    }
  }
}
