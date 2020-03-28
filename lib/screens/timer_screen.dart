import 'dart:async';
import 'dart:ui';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/constants/colors.dart';
import 'package:pomodoro/main.dart';
import 'package:pomodoro/models/title_item.dart';
import 'package:screen/screen.dart';
import 'package:toast/toast.dart';
import 'package:pomodoro/utils/duration_extension_methods.dart';

class TimerScreen extends StatefulWidget {

  static final id = 'timer';
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

enum CountdownType {
  WORK, REST
}

class _TimerScreenState extends State<TimerScreen> {

  Timer timer;

  Duration totalTime;
  Duration remainingTime;

  List<TitleItem> tasks;
  CountdownType countdownType = CountdownType.WORK;
  int currentTaskIndex = 0;

  AudioCache audioPlayer = AudioCache(prefix: 'sounds/');

  playSong(String path) async {
    audioPlayer.play(path);
  }

  @override
  void initState() {
    super.initState();
    Screen.keepOn(true);
    playSong('work.wav');
    timer = Timer.periodic(Duration(seconds: 1), (timer) => setState(updateTimer));
    totalTime = Duration(minutes: 25);
    remainingTime = Duration(minutes: 25);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tasks = ModalRoute.of(context).settings.arguments;
  }

  void updateTimer() {
    Duration newTime = remainingTime - Duration(seconds: 1);
    if (newTime.inSeconds >= 0) {
      remainingTime = newTime;
    } else {
      toggleType();
    }
  }

  void toggleType() {
    if (countdownType == CountdownType.WORK) {
      playSong('rest.wav');
      countdownType = CountdownType.REST;
      totalTime = Duration(minutes: 5);
      remainingTime = Duration(minutes: 5);
    } else {
      if (tasks != null) currentTaskIndex += 1;
      if (tasks != null && currentTaskIndex == tasks.length) {
        playSong('done.flac');
        Screen.keepOn(false);
        Navigator.pushReplacementNamed(context, MyHomePage.id);
      } else {
        playSong('work.wav');
        countdownType = CountdownType.WORK;
        totalTime = Duration(minutes: 25);
        remainingTime = Duration(minutes: 25);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: Colors.white,
              fontSize: 24
          ),
          child: Container(
            width: double.infinity,
            color: countdownType == CountdownType.REST ? Colors.green : tomato,
            child: Padding(
              padding: EdgeInsets.all(30),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(countdownType == CountdownType.REST ? "Repos" : tasks == null ? "Focus" : tasks[currentTaskIndex].title,
                      textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 50),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text("Temps écoulé", style: TextStyle(fontSize: 30),),
                        SizedBox(height: 20,),
                        Text((totalTime - remainingTime).format(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 60,
                            fontFeatures: [
                              FontFeature.tabularFigures()
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text("Temps restant", textAlign: TextAlign.right, style: TextStyle(fontSize: 30),),
                        SizedBox(height: 20,),
                        Text(remainingTime.format(),
                          style: TextStyle(
                            fontSize: 60,
                            fontFeatures: [
                              FontFeature.tabularFigures()
                            ],
                          ),
                        )
                      ],
                    ),
                    Center(
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.white
                            ),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        onPressed: () {
                          playSong('done.flac');
                          Navigator.pushReplacementNamed(context, MyHomePage.id);
                        },
                        child: Text("Terminer",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
