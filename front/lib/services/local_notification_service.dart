import 'dart:io';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService();

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  Future<void> initializePlatformNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    DateTime dateTime = DateTime.now();
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation(await FlutterNativeTimezone.getLocalTimezone()));

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      groupKey: 'com.example.flutter_push_notifications',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      color: const Color(0xff2196f3),
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(
      threadIdentifier: "thread1",
    );

    final details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      behaviorSubject.add(details.payload!);
    }
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);

    return platformChannelSpecifics;
  }

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  Future<void> showScheduledLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    required int seconds,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      platformChannelSpecifics,
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> showPeriodicLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();
    await flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.everyMinute,
      platformChannelSpecifics,
      payload: payload,
      androidAllowWhileIdle: true,
    );
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  void selectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      behaviorSubject.add(payload);
    }
  }

  Future<void> requestIOSPermissions() async {
    final bool? result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
}
