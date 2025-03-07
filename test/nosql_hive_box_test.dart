import 'dart:io';

import 'package:nosql_flutter_package/nosql_flutter_package.dart'
    show NoSqlHive;
import 'package:test/test.dart';

void main() {
  late Directory testDir;

  setUp(() async {
    testDir = await Directory.systemTemp.createTemp('hive_test');
    //Hive.init(testDir.path);
  });

  test('NoSqlHive opens a box correctly', () async {
    final db = NoSqlHive();
    final result = await db.init(subDir: testDir.path);
    expect(result, true);
    final box = await db.openBox<int>('test');
    expect(box, isNotNull);
  });

  tearDown(() async {
    //await Hive.deleteFromDisk();
    await testDir.delete(recursive: true);
  });
}
