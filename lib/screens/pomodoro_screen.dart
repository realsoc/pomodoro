import 'package:flutter/material.dart';

class PomodoroScreen extends StatefulWidget {
  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Je m'occupe pendant", style: TextStyle(fontSize: 27),),
            Text("25 min", style: TextStyle(fontSize: 35),),
            Text("Je me change les idées pendant", style: TextStyle(fontSize: 27), textAlign: TextAlign.center,),
            Text("5 min", style: TextStyle(fontSize: 35),),
            Text("Et je recommence...", style: TextStyle(fontSize: 27),),
          ]
      ),
    );
  }
}
