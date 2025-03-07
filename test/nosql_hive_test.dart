import 'dart:io';

import 'package:nosql_flutter_package/nosql_flutter_package.dart'
    show NoSqlHive;
import 'package:test/test.dart';

void main() {
  late Directory testDir;

  setUp(() async {
    testDir = await Directory.systemTemp.createTemp('hive_test');
  });

  test('NoSqlHive initializes correctly', () async {
    final db = NoSqlHive();
    final result = await db.init(subDir: testDir.path);
    expect(result, true);
  });

  test('NoSqlHive deletes from device', () async {
    final db = NoSqlHive();
    final initResult = await db.init(subDir: testDir.path);
    expect(initResult, true);
    final result = await db.deleteFromDevice();
    expect(result, true);
  });

  tearDown(() async {
    await testDir.delete(recursive: true);
  });
}
