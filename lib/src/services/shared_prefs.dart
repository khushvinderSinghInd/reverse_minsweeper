import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {

  static Future setBool({required String key, required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future getBool({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}
