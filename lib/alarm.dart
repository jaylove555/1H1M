import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

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
        timer.cancel();
        start = 60 * 60;
        startTimer();
        notifyListeners();
        playsound();
      } else if (isStopped) {
        timer.cancel();
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
    // PlayerAudio.play('found_sms_unread.mp3');
    // PlayerAudio.play(_CountdownTimerState().res);
    PlayerAudio.play(_CountdownTimerState().res.toString());
    notifyListeners();
  }
}

class _CountdownTimerState extends State<CountdownTimer> {
  List<String> itemsList = [
    'samma_arahang.wav',
    'meet_coming.mp3',
    'mail_coming.mp3',
    'have_new_message.mp3',
    'found_sms_unread.mp3',
    'fahsai_hallo.mp3'
  ];
  String? selectedItem = 'fahsai_hallo.mp3';

  String res = '';

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
            mainAxisAlignment: MainAxisAlignment.start,
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
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  width: 250,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.green))),
                    value: selectedItem,
                    items: itemsList
                        .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 15),
                            )))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => selectedItem = value.toString()),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  res = selectedItem.toString();
                }),
                child: Text('เลือกเสียง'),
              ),
              Text(res),
              ElevatedButton(onPressed: () => print(res), child: Text('กด'))
            ],
          ),
        ),
      ),
    );
  }
}
