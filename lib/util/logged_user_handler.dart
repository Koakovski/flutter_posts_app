import 'package:posts_app/classes/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggedUserHandler {
  static const _userIdKey = 'user_id';

  static get _prefs async {
    return SharedPreferences.getInstance();
  }

  static Future<void> logginUser(User user) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(_userIdKey, user.id);
  }

  static Future<int?> userId() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(_userIdKey);
  }

  static Future<bool> isUserLoggedIn() async {
    return (await userId()) != null;
  }
}
