import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ButtonPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ButtonPage extends StatefulWidget {
  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  Timer _timer;
  int _start = 3;
  int _counter = 0;
  bool _started = false;
  Color _buttonColor = Colors.redAccent;
  DateTime _startTime = DateTime.now();
  List<double> _clicks = new List();
  List<int> _graph = new List();

  //List<int> formatToGraph(int N)
  //{
  //  List<Tuple2<double, double>> = new List(10);
  //}

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            if (_started) {
              _clicks.sort();
              print(_clicks);
              print("1");
              print("2");
              _buttonColor = Colors.redAccent;

              timer.cancel();
              _started = false;
              _start = 3;
            } else {
              _buttonColor = Colors.greenAccent;
              _startTime = DateTime.now();
              _clicks = List();

              timer.cancel();
              _start = 20;
              startTimer();
              _started = true;
            }
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _buttonColor,
        title: Text("Mental state analyzer"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 200.0,
              child: RaisedButton(
                child: Text("Start"),
                onPressed: () {
                  setState(() {
                    _counter = 0;
                  });
                  startTimer();
                },
              ),
            ),
            Text(
              "$_start",
              style: TextStyle(fontSize: 30.0),
            ),
            Text(
              "$_counter",
              style: TextStyle(fontSize: 30.0),
            ),
            Container(
              height: 100.0,
            ),
            Container(
              height: 200.0,
              width: 200.0,
              child: RaisedButton(
                color: _buttonColor,
                onPressed: () {
                  if (_started) {
                    setState(() {
                      _clicks.add((DateTime.now().second - _startTime.second)
                              .toDouble() +
                          (DateTime.now().millisecond - _startTime.millisecond)
                                  .toDouble() /
                              1000.0);
                      _counter += 1;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
