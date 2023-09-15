import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  NotificationHelper._();

  static final NotificationHelper notification_helper = NotificationHelper._();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initNotification() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOs = const DarwinInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(
      initSetttings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        log("===========================================================================");
        log("===========================================================================");
        log("${notificationResponse.payload}");
        log("${notificationResponse.notificationResponseType}");
        log("===========================================================================");
        log("===========================================================================");
      },
    );
  }

  Future<void> SimpleNotification() async {
    var android = const AndroidNotificationDetails('id', 'channel ',
        channelDescription: 'description',
        priority: Priority.high,
        importance: Importance.max);
    var iOS = const DarwinNotificationDetails();
    var platform = new NotificationDetails(iOS: iOS, android: android);
    await flutterLocalNotificationsPlugin.show(
        0, 'Flutter Chat App', 'Message From Mathakhut.....', platform,
        payload: 'Welcome to the Local Notification demo');
  }

  Future<void> ScheduledNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      icon: 'mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Flutter Chat App',
        'Message From Vavajodu..............',
        tz.TZDateTime.now(tz.UTC).add(Duration(seconds: 5)),
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: "Ha ha bhai chale chw maja karo .....");
  }

  Future<void> bigPictureNotification() async {
    var bigPictureStyleInformation = const BigPictureStyleInformation(
      DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
      largeIcon: DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
      contentTitle: 'Flutter Chat App',
      summaryText: 'New Content Alert.......',
    );
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'big text channel id', 'big text channel name',
        channelDescription: 'big text channel description',
        styleInformation: bigPictureStyleInformation);
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Flutter App',
      'Message From Mine',
      platformChannelSpecifics,
    );
  }

  Future<void> mediaStyleNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      channelDescription: 'media channel description',
      color: Colors.yellow,
      enableLights: true,
      largeIcon: DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
      styleInformation: MediaStyleInformation(),
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'Flutter Chat App',
        'Its the Demo of MediaStyle Notification', platformChannelSpecifics);
  }
}
