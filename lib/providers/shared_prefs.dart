import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  late final SharedPreferences _prefs;

  static const _darkmode = 'DarkMode';
  static const _hour = 'NOTIF_HOUR';
  static const _minute = 'NOTIF_MINUTE';

  UserPrefs._();
  static final UserPrefs _instance = UserPrefs._();
  factory UserPrefs() => _instance;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get darkMode => _prefs.getBool(_darkmode) ?? true;
  set darkMode(bool value) => _prefs.setBool(_darkmode, value);

  int get hour => _prefs.getInt(_hour) ?? 99;
  set hour(int v) => _prefs.setInt(_hour, v);

  int get minute => _prefs.getInt(_minute) ?? 99;
  set minute(int v) => _prefs.setInt(_minute, v);

  deleteTime() {
    _prefs.remove(_hour);
    _prefs.remove(_minute);
  }
}
