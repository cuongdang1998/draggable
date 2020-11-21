import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static UserPreference _userPrf;
  static UserPreference get userPrf {
    _userPrf ??= UserPreference();
    return _userPrf;
  }

  save(String key, value) async {
    final spf = await SharedPreferences.getInstance();
    return spf.setString(key, value);
  }

  read(String key) async {
    final spf = await SharedPreferences.getInstance();
    return spf.getString(key);
  }

  remove(String key) async {
    final spf = await SharedPreferences.getInstance();
    spf.remove(key);
  }
}
