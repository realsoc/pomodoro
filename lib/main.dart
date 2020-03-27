import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/components/dialogs.dart';
import 'package:pomodoro/constants/colors.dart';
import 'package:pomodoro/models/title_item.dart';
import 'package:pomodoro/my_flutter_app_icons.dart';
import 'package:pomodoro/screens/infos_screen.dart';
import 'package:pomodoro/screens/pomodoro_screen.dart';
import 'package:pomodoro/screens/tasks_screen.dart';
import 'package:pomodoro/screens/timer_screen.dart';
import 'package:toast/toast.dart';

import 'constants/tab.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
          fontFamily: 'Tomato',
          primarySwatch: tomato
      ),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        fontFamily: 'Tomato',
        primarySwatch: tomato,
      ),
      home: MyHomePage(title: 'Liste'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<TitleItem> tasks = [];

  TabType selectedTab = TabType.LIST;

  Widget _getScreen() {
    switch(selectedTab) {
      case TabType.LIST:
        return TasksScreen(tasks, (titleItem) {
          setState(() {
            tasks.remove(titleItem);
          });
        });
        break;
      case TabType.POMODORO:
        return PomodoroScreen();
        break;
      case TabType.INFO:
        return InfosScreen();
        break;
    }
    return null;
  }

  // ignore: missing_return
  Widget _getFAB() {
    switch(selectedTab) {
      case TabType.LIST:
        return FloatingActionButton(
          onPressed: _newTask,
          tooltip: 'Add a task',
          child: Icon(Icons.add),
        );
        break;
      case TabType.POMODORO:
        return FloatingActionButton(
          onPressed: _startTimer,
          tooltip: 'Start timer',
          child: Icon(Icons.play_arrow),
        );
        break;
      case TabType.INFO:
        return null;
        break;
    }
  }

  // ignore: missing_return
  Widget _getAppBar() {
    switch(selectedTab) {
      case TabType.LIST:
        return AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Liste"),
          actions: <Widget>[
            FlatButton(
              child: Icon(Icons.play_arrow, color: Colors.white,),
              onPressed: () {
                if (tasks.isEmpty) {
                  showDialog(context: context, child: TextDialog(
                    title: "Warning",
                    text: "Please enter at least a task before launching the timer",
                    confirmLabel: "ok",
                  ));
                } else {
                  Toast.show("Start timer", context);
                }
              },
            )
          ],
        );
        break;
      case TabType.POMODORO:
        return AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Pomodoro"),
        );
        break;
      case TabType.INFO:
        return AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Infos"),
        );
        break;
    }

  }

  void _newTask() async {
    String newTask = await showDialog(
        context: context,
        child: InputDialog(
          title: "New Task",
          cancelLabel: "Cancel",
          confirmLabel: "Add",
          hint: "Add a new task",
        ));
    if (newTask != null && newTask.isNotEmpty) {
      setState(() {
        tasks.add(TitleItem(newTask));
      });
    }
  }

  void _startTimer() {
    Toast.show("Start timer", context);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: _getAppBar(),
      extendBody: selectedTab == TabType.LIST && tasks.isNotEmpty ? true : false,
      bottomNavigationBar: CurvedNavigationBar(
        color: Color(0xFFD32F2F),
        backgroundColor: Colors.transparent,
        items: <Widget>[
          Icon(Icons.list, color: Colors.white,),
          Icon(CustomIcons.tomato, color: Colors.white,),
          Icon(Icons.info, color: Colors.white)
        ],
        onTap: (index) {
          setState(() {

            selectedTab = TabType.values[index];
          });
        },
      ),
      body: _getScreen(),
      floatingActionButton: _getFAB(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
