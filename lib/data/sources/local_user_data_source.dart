import 'package:hive/hive.dart';

class LocalUserDataSource {
  final Box _box;

  LocalUserDataSource(this._box);

  Future<void> saveUser(String key, String value) async {
    await _box.put(key, value);
  }

  String? getUser(String key) {
    return _box.get(key);
  }
}
