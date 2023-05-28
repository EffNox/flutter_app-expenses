import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzAll;
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  final _plugin = FlutterLocalNotificationsPlugin();

  init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/star');
    const initSettings = InitializationSettings(android: androidInit);

    tzAll.initializeTimeZones();
    await _plugin.initialize(initSettings);
    tz.setLocalLocation(tz.getLocation('America/Lima'));
  }

  dailyNotification(int hour, int minute) async {
    final now = tz.TZDateTime.now(tz.local);

    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    print('scheduledDate: $scheduledDate');

    var bigImage = const BigPictureStyleInformation(
      DrawableResourceAndroidBitmap('@mipmap/boo'),
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/star'),
      contentTitle: 'Es hora de registrar gastos',
      summaryText: 'No olvides registrar los gastos del día',
      htmlFormatContent: true,
      htmlFormatTitle: true,
    );

    var notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        '1',
        'name',
        styleInformation: bigImage,
      ),
    );

    await _plugin.zonedSchedule(
      1,
      'Llego el momento',
      'No olvides registrar tus gastos',
      scheduledDate,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // weekNotification()async{}

  cancelNotification() async {
    await _plugin.cancelAll();
  }
}
