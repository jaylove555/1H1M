// import 'package:flutter_application/main.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationWidget {
//   static final _notification = FlutterLocalNotificationsPlugin();

//   static Future init({bool schedule = false}) async {
//     var initAndroidSettings =
//         AndroidInitializationSettings('mipmap/ic_launcher');
//     var ios = IOSInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//         onDidReceiveLocalNotification:
//             (int id, String title, String body, String payload) async {});
//     final setting =
//         InitializationSettings(android: initAndroidSettings, iOS: ios);
//     await _notification.initialize(setting);
//   }

//   static Future showNotification({
//     var id = 0,
//     var title,
//     var body,
//     var payload,
//   }) async =>
//       _notification.show(id, title, body, await NotificationDetails());

//   static notificationDetails() async {
//     return const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'chanel id',
//           'chanel name',
//           importance: Importance.max,
//         ),
//         iOS: DarwinNotificationDetails(presentSound: false));
//   }
// }
