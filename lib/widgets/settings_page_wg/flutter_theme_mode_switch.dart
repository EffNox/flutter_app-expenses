import 'package:expenses/providers/shared_prefs.dart';
import 'package:expenses/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchThemeWidget extends StatefulWidget {
  const SwitchThemeWidget({Key? key}) : super(key: key);

  @override
  State<SwitchThemeWidget> createState() => _SwitchThemeWidgetState();
}

class _SwitchThemeWidgetState extends State<SwitchThemeWidget> {
  final prefs = UserPrefs();
  var darkMode = false;

  @override
  void initState() {
    super.initState();
    darkMode = prefs.darkMode;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        'Modo ${darkMode ? 'Oscuro' : 'Claro'}',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'El modo ${darkMode ? 'oscuro ayuda a ahorrar' : 'claro ayuda a gastar'} batería',
      ),
      // activeColor: Colors.amberAccent,
      secondary: Icon(
        darkMode ? Icons.brightness_2_outlined : Icons.brightness_7_outlined,
        size: 35,
      ),
      value: darkMode,
      onChanged: (value) {
        prefs.darkMode = value;
        setState(() => darkMode = value);
        context.read<ThemeProvider>().swapTheme();
      },
    );
  }
}
