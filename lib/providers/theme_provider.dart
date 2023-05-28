import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _selectedTheme;

  final _dark = ThemeData.dark(useMaterial3: true).copyWith(
      // appBarTheme: AppBarTheme(backgroundColor: Colors.grey[800]),
      scaffoldBackgroundColor: const Color(0xff121212),
      primaryColorDark: Colors.grey[850],
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.greenAccent,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 81, 150, 85),
        foregroundColor: Colors.white,
      ),
      colorScheme: const ColorScheme.dark(
        primary: Colors.green,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return null;
          if (states.contains(MaterialState.selected)) return Colors.black12;
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return null;
          if (states.contains(MaterialState.selected)) return Colors.amber;
          return null;
        }),
      ));

  final _light = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: Colors.grey[200],
    primaryColorDark: Colors.black12,
    dividerColor: Colors.black,
  );

  ThemeProvider(bool isDark) {
    _selectedTheme = (isDark) ? _dark : _light;
  }

  Future<void> swapTheme() async {
    if (_selectedTheme == _dark) {
      _selectedTheme = _light;
    } else {
      _selectedTheme = _dark;
    }
    notifyListeners();
  }

  ThemeData getTheme() => _selectedTheme;
}
