import 'package:hive/hive.dart';
import 'package:paddle_jakarta/data/models/user_model.dart';

class LocalUserDataSource {
  final Box<UserModel> _box;
  final userKey = 'userData';

  LocalUserDataSource(this._box);

  saveUserData(UserModel value) async {
    await _box.put(userKey, value);
  }

  UserModel? getUser() {
    return _box.get(userKey);
  }

  clearUserData() async {
    await _box.delete(userKey);
  }
}
