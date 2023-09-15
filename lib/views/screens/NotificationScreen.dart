import 'dart:developer';

import 'package:chat_app_using_firebase/helper/ApiHelper.dart';
import 'package:chat_app_using_firebase/helper/NotificationHelper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> getFCMToken() async {
    String? token = await messaging.getToken();
    log("===================================================");
    log("FCM TOKEN:- ${token}");
    log("===================================================");
  }

  Future<void> FCMforgroundMesage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Flutter Chat App"),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${message.notification?.title}"),
                Text("${message.notification?.body}")
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationHelper.notification_helper.initNotification();
    FCMforgroundMesage();
    getFCMToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  NotificationHelper.notification_helper.SimpleNotification();
                },
                child: Text("Simple Notification")),
            ElevatedButton(
                onPressed: () {
                  NotificationHelper.notification_helper
                      .ScheduledNotification();
                },
                child: Text("Scheduled Notification")),
            ElevatedButton(
                onPressed: () {
                  NotificationHelper.notification_helper
                      .mediaStyleNotification();
                },
                child: Text("Media Style Notification")),
            ElevatedButton(
                onPressed: () {
                  NotificationHelper.notification_helper
                      .bigPictureNotification();
                },
                child: Text("Big Picture Notification")),
            ElevatedButton(
                onPressed: () {
                  ApiHelper.apiHelper.sendNotification();
                },
                child: Text("Send FCM Notification")),
          ],
        ),
      ),
    );
  }
}
