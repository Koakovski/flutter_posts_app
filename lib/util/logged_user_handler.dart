import 'package:shared_preferences/shared_preferences.dart';

class LoggedUserHandler {
  static const _userIdKey = 'user_id';

  static get _prefs async {
    return SharedPreferences.getInstance();
  }

  static Future<void> loggin(int userId) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(_userIdKey, userId);
  }

  static Future<int?> userId() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(_userIdKey);
  }

  static Future<bool> isUserLoggedIn() async {
    return (await userId()) != null;
  }

  static Future<void> loggout() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(_userIdKey);
  }
}
