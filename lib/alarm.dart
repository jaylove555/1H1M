import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int _start = 1;
  bool _isCountingDown = false;
  bool _isStopped = false;
  Timer? _timer;

  void startTimer() {
    _isCountingDown = true;
    _isStopped = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start < 1) {
          _isCountingDown = false;
          _timer?.cancel();
          _showNotification();
          _start = 60 * 60;
          startTimer();
        } else if (_isStopped) {
          _timer?.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  void stopTimer() {
    _isStopped = true;
    _timer?.cancel();
    _isCountingDown = false;
    setState(() {});
  }

  void resetTimer() {
    if (_isCountingDown) {
      _timer?.cancel();
    }
    _isCountingDown = false;
    _isStopped = false;
    _start = 60 * 60;
    setState(() {});
  }

  // Future<void> _showNotification() async {
  //   var androidDetails =
  //       AndroidNotificationDetails('Local Notification', 'description');
  //   var iosDetails = IOSNotificationDetails();
  //   var platformDetails =
  //       NotificationDetails(android: androidDetails, iOS: iosDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, 'Countdown Timer', '60 minutes has passed', platformDetails,
  //       payload: 'payload');
  // }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    // await flutterLocalNotificationsPlugin.show(
    //   0,
    //   'Countdown Timer',
    //   '60 minutes has passed',
    //   notificationDetails,
    //   payload: 'payload',
    // );
    await flutterLocalNotificationsPlugin.show(
      0,
      'สวัสดี',
      'hello',
      notificationDetails,
      payload: 'payload',
    );
  }

  @override
  void initState() {
    // super.initState();
    // var initializationSettingsAndroid =
    //     AndroidInitializationSettings('app_icon');
    // var initializationSettingsIOS = IOSInitializationSettings();
    // var initializationSettings = InitializationSettings(
    //     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    // flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Color(0xFF2D2F41),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 300,
                            height: 300,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey.shade300,
                              strokeWidth: 6,

                              // LinearGradient(colors: [
                              //   Colors.greenAccent.shade200,
                              //   Colors.blueAccent.shade400
                              // ]),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${(_start / 60).toInt()}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontFamily: 'Avenir',
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                ':',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontFamily: 'Avenir',
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                '${(_start % 60).toString().padLeft(2, "0")}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontFamily: 'Avenir',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _isCountingDown ? null : startTimer,
                    child: Text('Start'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _isStopped ? null : stopTimer,
                    child: Text('Stop'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: resetTimer,
                    child: Text('Reset'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  IOSNotificationDetails(
      {required String sound,
      required bool presentAlert,
      required bool presentBadge,
      required bool presentSound}) {}
}
