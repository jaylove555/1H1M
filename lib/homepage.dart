import 'package:flutter/material.dart';
import 'package:flutter_application/alarm.dart';
import 'package:flutter_application/clockpage.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFF2D2F41),
        body: TabBarView(
          children: <Widget>[
            ClockPage(),
            CountdownTimer(),
          ],
        ),
        bottomNavigationBar: Container(
          color: Color(0xFF2D2F41),
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.grey,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.lock_clock),
                child: new Text(
                  "Home",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Tab(
                icon: Icon(Icons.alarm),
                child: new Text(
                  "Alarm",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
