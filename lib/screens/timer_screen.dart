import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
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
            color: Colors.green,
            child: Padding(
              padding: EdgeInsets.all(30),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Focus", textAlign: TextAlign.center,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text("Temps écoulé"),
                        SizedBox(height: 20,),
                        Text("12:21",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 60),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text("Temps restant", textAlign: TextAlign.right,),
                        SizedBox(height: 20,),
                        Text("12:29",
                          style: TextStyle(fontSize: 60),
                        )
                      ],
                    ),
                    Center(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.white
                            ),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        onPressed: () {
                          Toast.show("Terminer", context);
                        },
                        child: Text("Terminer",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24
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
