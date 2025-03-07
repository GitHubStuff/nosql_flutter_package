import 'dart:async' show FutureOr;

abstract class NoSqlDB {
  FutureOr<bool> init({String subDir = 'nosql_db'});
  FutureOr<bool> deleteFromDevice();
  FutureOr<NoSqlBox<T>?> openBox<T>(String boxName);
}

abstract class NoSqlBox<T> {
  FutureOr<bool> put(dynamic key, T value);
  FutureOr<T?> get(dynamic key, {T? defaultValue});
  // FutureOr<bool> delete(String key);
  // FutureOr<bool> clear();
  // FutureOr<int> getLength();
  // FutureOr<List<String>> getKeys();
  // FutureOr<List<T>> getValues<T>();
  // FutureOr<bool> containsKey(String key);
  // FutureOr<bool> containsValue<T>(T value);
  // FutureOr<void> close();
}
