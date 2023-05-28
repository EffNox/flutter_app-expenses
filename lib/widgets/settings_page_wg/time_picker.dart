import 'package:expenses/providers/local_notifications.dart';
import 'package:expenses/providers/shared_prefs.dart';
import 'package:expenses/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget({Key? key}) : super(key: key);

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  final _notif = LocalNotifications();
  final _prefs = UserPrefs();
  var _isEnabled = false;
  var _title = 'Activar notificaciones';

  @override
  Widget build(BuildContext context) {
    final getDate = DateTime.now();
    String currentTime;

    if (_prefs.hour != 99) {
      final getTime = DateTime(
          getDate.year, getDate.month, getDate.day, _prefs.hour, _prefs.minute);
      currentTime = DateFormat.jm().format(getTime);
      _title = 'Desactivar notificaciones';
      _isEnabled = true;
    } else {
      currentTime = 'Desactivado';
      _title = 'Activar notificaciones';
      _isEnabled = false;
    }

    cancelNotification(bool v) {
      if (v == true) {
        _prefs.hour = 21;
        _prefs.minute = 30;
        _notif.dailyNotification(21, 30);
      } else {
        _prefs.deleteTime();
        _notif.cancelNotification();
      }
    }

    return Column(
      children: [
        SwitchListTile(
          title: Text(_title),
          // subtitle: const Text('Notificación de gastos'),
          value: _isEnabled,
          onChanged: (value) {
            setState(() {
              _isEnabled = value;
              cancelNotification(value);
            });
          },
        ),
        ListTile(
          enabled: _isEnabled,
          leading: Icon(
            _isEnabled
                ? Icons.notifications_active_outlined
                : Icons.notifications_off_outlined,
            size: 35,
          ),
          title: const Text('Recordatorio Diario'),
          subtitle: Text(currentTime),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          onTap: _selectedTime,
        ),
      ],
    );
  }

  void _selectedTime() {
    int hour = 0;
    int minute = 0;

    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Establece una hora para enviar una notificación diaria.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              TimePickerSpinner(
                time: DateTime.now(),
                is24HourMode: false,
                spacing: 70,
                itemHeight: 70,
                itemWidth: 70,
                isForce2Digits: true,
                normalTextStyle: TextStyle(
                  fontSize: 30,
                  color: Colors.grey.shade600,
                ),
                highlightedTextStyle: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                onTimeChange: (time) {
                  // debugPrint('time: ${time.toString()}');
                  setState(() {
                    hour = time.hour;
                    minute = time.minute;
                  });
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Constants.customButton(
                          Colors.transparent, Colors.red, 'CANCELAR'),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Constants.customButton(
                          Colors.green, Colors.transparent, 'ACEPTAR'),
                      onTap: () {
                        setState(() {
                          _prefs.hour = hour;
                          _prefs.minute = minute;
                          _notif.dailyNotification(hour, minute);
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
