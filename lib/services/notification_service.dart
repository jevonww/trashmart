import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await notifications.initialize(settings);

    await notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> scheduleDailyReminder() async {
    final scheduledDate = _nextInstanceOfTime(8, 0);

    await notifications.zonedSchedule(
      0,
      '♻️ Pengingat TrashSmart',
      'Sudahkah kamu membuang sampah pada tempatnya hari ini?',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'trashsmart_reminder',
          'TrashSmart Reminder',
          channelDescription: 'Pengingat membuang sampah',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> showTestNotification() async {
    await notifications.show(
      999,
      '♻️ Pengingat TrashSmart',
      'Sudahkah kamu membuang sampah hari ini?',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'trashsmart_test',
          'TrashSmart Test Notification',
          channelDescription: 'Notifikasi uji TrashSmart',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  static Future<void> cancelAllNotifications() async {
    await notifications.cancelAll();
  }

  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}