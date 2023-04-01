import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/alarm_provider.dart';
import 'package:provider/provider.dart';

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
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
  String? selectedItem = 'samma_arahang.wav';

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
              Row(
                children: [
                  ElevatedButton(
                      child: Text('อย่ากด'),
                      onPressed: () {
                        final PlayerAudio = AudioCache();
                        PlayerAudio.play("have_new_message_coming.mp3");
                      }),
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
                    onChanged: (item) => setState(() => selectedItem = item),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
