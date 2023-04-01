import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

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
    playsound();
  }

  Future<void> playsound() async {
    final PlayerAudio = AudioCache();
    PlayerAudio.play('samma_arahang.wav');
    notifyListeners();
  }
}
