import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  AppPrefs._();

  static late SharedPreferences _prefs;

  /// Call once in main()
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // -------- SET --------
  static Future<void> setString(String key, String value) async =>
      _prefs.setString(key, value);

  static Future<void> setBool(String key, bool value) async =>
      _prefs.setBool(key, value);

  static Future<void> setInt(String key, int value) async =>
      _prefs.setInt(key, value);

  static Future<void> setDouble(String key, double value) async =>
      _prefs.setDouble(key, value);

  // -------- GET --------
  static String getString(String key) => _prefs.getString(key)??"";

  static bool getBool(String key) => _prefs.getBool(key)??false;

  static int getInt(String key) => _prefs.getInt(key)??-1;

  static double getDouble(String key) => _prefs.getDouble(key)??-1.0;

  // -------- REMOVE --------
  static Future<void> remove(String key) async =>
      _prefs.remove(key);

  static Future<void> clear() async =>
      _prefs.clear();
}
