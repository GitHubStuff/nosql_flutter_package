// no_sql_hive_box_test.dart
import 'package:hive_ce/hive.dart' show Box;
import 'package:nosql_flutter_package/nosql_flutter_package.dart';
import 'package:test/test.dart';

// A fake Box implementation to simulate Hive behavior
class FakeBox<T> implements Box<T> {
  // Internal storage map
  final Map<dynamic, T> data = {};

  // Flags to simulate exceptions
  bool throwOnGet = false;
  bool throwOnPut = false;

  @override
  T? get(dynamic key, {T? defaultValue}) {
    if (throwOnGet) throw Exception('Simulated get error');
    return data.containsKey(key) ? data[key] : defaultValue;
  }

  @override
  Future<void> put(dynamic key, T value) async {
    if (throwOnPut) throw Exception('Simulated put error');
    data[key] = value;
  }

  // Other Box methods can be left unimplemented for testing purposes.
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('NoSqlHiveBox', () {
    test('get returns value from box', () async {
      final fakeBox = FakeBox<String>();
      fakeBox.data['key1'] = 'value1';
      final noSqlBox = NoSqlHiveBox<String>(fakeBox);

      final result = noSqlBox.get('key1');
      expect(result, equals('value1'));
    });

    test('get returns defaultValue when key is not found', () async {
      final fakeBox = FakeBox<String>();
      final noSqlBox = NoSqlHiveBox<String>(fakeBox);

      final result = noSqlBox.get('nonexistent', defaultValue: 'default');
      expect(result, equals('default'));
    });

    // Test when throwOnGet is true: should return null when an exception occurs.
    test('get returns null when an exception occurs', () async {
      final fakeBox = FakeBox<String>()..throwOnGet = true;
      final noSqlBox = NoSqlHiveBox<String>(fakeBox);

      final result = noSqlBox.get('key');
      expect(result, isNull);
    });

    test('put stores value and returns true', () async {
      final fakeBox = FakeBox<String>();
      final noSqlBox = NoSqlHiveBox<String>(fakeBox);

      final result = await noSqlBox.put('key', 'value');
      expect(result, isTrue);
      expect(fakeBox.data['key'], equals('value'));
    });

    // Test when throwOnPut is true: should return false when an exception occurs.
    test('put returns false when an exception occurs', () async {
      final fakeBox = FakeBox<String>()..throwOnPut = true;
      final noSqlBox = NoSqlHiveBox<String>(fakeBox);

      final result = await noSqlBox.put('key', 'value');
      expect(result, isFalse);
    });
  });
}
