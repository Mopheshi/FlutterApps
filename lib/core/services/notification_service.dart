import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart';

import '../../features/todo/models/task_model.dart';

class NotificationService {
  const NotificationService._();

  static final _notificationDispatcher = FlutterLocalNotificationsPlugin();
  static final notificationStream = BehaviorSubject<String?>();

  static Future<void> init() async {
    await _notificationDispatcher
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();

    const androidSettings = AndroidInitializationSettings('notification_icon');
    final iOSSettings = DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) {
      notificationStream.add(payload);
    });

    final settings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    final details =
        await _notificationDispatcher.getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp ?? false) {
      notificationStream.add(details!.notificationResponse!.payload);
    }

    await _notificationDispatcher.initialize(settings,
        onDidReceiveNotificationResponse: (response) {
      notificationStream.add(response.payload);
    });
    await initTimeZone();
  }

  static Future<void> initTimeZone() async {
    tz.initializeTimeZones();
    final currentTimeZone = await FlutterTimezone.getLocalTimezone();
    setLocalLocation(getLocation(currentTimeZone));
  }

  static NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        channelDescription: 'channelDescription',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  static Future<void> scheduleNotification(TaskModel task) async {
    final timeFromTimeZone = TZDateTime.from(task.startTime!, local);
    if (timeFromTimeZone
        .isBefore(TZDateTime.now(local).add(const Duration(minutes: 1)))) {
      return;
    }
    await _notificationDispatcher.zonedSchedule(
      task.id!,
      task.title,
      task.description,
      timeFromTimeZone,
      _notificationDetails(),
      payload: jsonEncode(task.toMap()),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await _notificationDispatcher.cancel(id);
  }

  static Future<void> editNotification(TaskModel task) async {
    await cancelNotification(task.id!);
    await scheduleNotification(task);
  }
}
