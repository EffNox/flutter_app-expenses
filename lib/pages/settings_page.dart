import 'package:expenses/widgets/settings_page_wg/flutter_theme_mode_switch.dart';
import 'package:expenses/widgets/settings_page_wg/time_picker.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        children: const [
          SwitchThemeWidget(),
          Divider(),
          TimePickerWidget(),
          Divider(),
        ],
      ),
    );
  }
}
