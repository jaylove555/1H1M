import 'package:flutter/material.dart';
import 'package:flutter_application/alarm.dart';
import 'package:flutter_application/alarm_provider.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

AudioPlayer audioPlayer = AudioPlayer();

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Alarm(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CountdownTimer(),
      ),
    );
  }
}
