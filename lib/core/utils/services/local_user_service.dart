import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LocalUserService {
  static const _key = 'local_user_id';
  static const _nameKey = 'local_user_name';

  static Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(_key);

    if (uid == null) {
      uid = const Uuid().v4();
      await prefs.setString(_key, uid);
    }
    return uid;
  }

  static Future<void> setName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
  }

  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey) ?? 'User';
  }

  static Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString(_key);
    if (uid == null) {
      uid = const Uuid().v4();
      await prefs.setString(_key, uid);
    }
    return uid;
  }
}
