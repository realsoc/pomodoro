import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pomodoro/models/title_item.dart';
import 'package:toast/toast.dart';

class TasksScreen extends StatefulWidget {

  final List<TitleItem> tasks;
  final Function onDismissed;

  TasksScreen(this.tasks, this.onDismissed);

  @override
  _TasksScreenState createState() => _TasksScreenState();


}

class ListItem extends StatelessWidget {
  final int index;
  final Widget child;

  ListItem(this.index, this.child);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}


class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.tasks.isNotEmpty ? Container(
      child: ReorderableListView(
          scrollDirection: Axis.vertical,
          onReorder: (oldIndex, newIndex) {
            setState(
                  () {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final TitleItem item = widget.tasks.removeAt(oldIndex);
                widget.tasks.insert(newIndex, item);
              },
            );
          },
          children: widget.tasks
              .asMap()
              .map(
                  (i, e) =>
                  MapEntry(i, Dismissible(
                    direction: DismissDirection.endToStart,
                    key: Key(i.toString()),
                    child: ListItem(i,
                        ListTile(
                            title: Text(e.title)
                        )
                    ),
                    onDismissed: (direction) {
                      Toast.show("Task ${e.title} removed", context);
                      widget.onDismissed(e);
                    },

                    background: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.red
                      ),
                    ),
                  ),
                  )).values.toList(),
    )) : _getEmptyState();
  }
}


Widget _getEmptyState() {
  return Center(
    child:  Lottie.asset('assets/anims/load-cards-animation.json'),
  );
}