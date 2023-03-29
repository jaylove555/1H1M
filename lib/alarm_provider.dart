import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

List<String> sounds = [
  'samma_arahang.wav',
  'fahsai_hallo.wav',
  'found_sms_unread.wav',
  'have_new_message_coming.wav',
  'have_new_message_coming.wav',
  'mail_coming.wav',
  'meet_coming.wav'
];
String selectedSound = 'samma_arahang.wav';

class Alarm extends ChangeNotifier {
  int start = 60 * 60;
  bool isCountingDown = false;
  bool isStopped = false;
  Timer? timer;

  void startTimer() {
    isCountingDown = true;
    isStopped = false;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (start < 1) {
        isCountingDown = false;
        timer?.cancel();
        start = 60 * 60;
        // showNotification();
        startTimer();
        notifyListeners();
      } else if (isStopped) {
        timer?.cancel();
        notifyListeners();
      } else {
        start--;
        notifyListeners();
      }
    });
  }

  void stopTimer() {
    isStopped = true;
    timer?.cancel();
    isCountingDown = false;
    notifyListeners();
  }

  void resetTimer() {
    if (isCountingDown) {
      timer?.cancel();
    }
    isCountingDown = false;
    isStopped = false;
    start = 60 * 60;
    showNotification();
    notifyListeners();
  }

  Future<void> showNotification() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('have_new_message_coming'),
    );
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      sound: 'have_new_message_coming.wav',
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'Title', 'Body', platformChannelSpecifics);
  }

  Future<void> onSelectNotification(String? payload) async {
    // handle notification tap event here
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // handle notification display event here
  }
}
