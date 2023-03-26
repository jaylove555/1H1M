import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application/alarm_provider.dart';
import 'package:flutter_application/notification_widget.dart';
import 'package:flutter_application/theme_data.dart';
import 'package:provider/provider.dart';

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  @override
  void dispose() {
    // _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // NotificationWidget.init();
  }

  @override
  Widget build(BuildContext context) {
    int _countdown = context.watch<Alarm>().start;
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
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer<Alarm>(
                                builder: (context, value, child) {
                                  return Text(
                                    '${(value.start / 60).toInt()}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontFamily: 'Avenir',
                                    ),
                                  );
                                },
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
                              Consumer<Alarm>(
                                builder: (context, value, child) {
                                  return Text(
                                    '${(value.start % 60).toString().padLeft(2, "0")}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontFamily: 'Avenir',
                                    ),
                                  );
                                },
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
                  Consumer<Alarm>(
                    builder: (context, value, child) {
                      return ElevatedButton(
                        onPressed:
                            value.isCountingDown ? null : value.startTimer,
                        child: Text(
                          'Start',
                          style: TextStyle(fontSize: 20, fontFamily: 'Avenir'),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 20),
                  Consumer<Alarm>(
                    builder: (context, value, child) {
                      return ElevatedButton(
                        onPressed: value.isStopped ? null : value.stopTimer,
                        child: Text(
                          'Stop',
                          style: TextStyle(fontSize: 20, fontFamily: 'Avenir'),
                        ),
                        // style: ElevatedButton.styleFrom(
                        //   primary: Colors.lightBlue,
                        // ),
                      );
                    },
                  ),
                  SizedBox(width: 20),
                  Consumer<Alarm>(
                    builder: (context, value, child) {
                      return ElevatedButton(
                        onPressed: value.resetTimer,
                        child: Text(
                          'Reset',
                          style: TextStyle(fontSize: 20, fontFamily: 'Avenir'),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
