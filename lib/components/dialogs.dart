import 'package:flutter/material.dart';
import 'package:pomodoro/constants/colors.dart';

class _BaseDialog extends StatefulWidget {

  final Widget child;
  final String title;

  _BaseDialog({this.child, this.title});
  @override
  _BaseDialogState createState() => _BaseDialogState();
}

class _BaseDialogState extends State<_BaseDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: tomato,
      title: Text(widget.title, style: TextStyle(fontSize: 20, color: Colors.white),),
      content: widget.child,
    );
  }
}

class TextDialog extends StatelessWidget {

  final String text;
  final String title;
  final String confirmLabel;

  TextDialog({this.text, this.title, this.confirmLabel});

  @override
  Widget build(BuildContext context) {
    return _BaseDialog(
      title: title != null ? title : "",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Text(text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          FlatButton(
            onPressed: () {
              Navigator.pop(context, 'success');
            },
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Text(confirmLabel, style: TextStyle(fontSize: 20, color: Colors.white),),
          )
        ],
      ),
    );
  }
}

class InputDialog extends StatefulWidget {


  final String title;
  final String confirmLabel;
  final String cancelLabel;
  final String hint;

  InputDialog({this.title, this.confirmLabel, this.cancelLabel, this.hint});

  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {

  String input = "";

  @override
  Widget build(BuildContext context) {
    return _BaseDialog(
      title: widget.title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            autofocus: true,
            onChanged: (newText) {
              setState(() {
                input = newText;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 0, style: BorderStyle.none),
                borderRadius: BorderRadius.circular(5)
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: widget.hint
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                textColor: Colors.white,
                child: Text(widget.cancelLabel,),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Colors.white),
                ),
                child: Text(widget.confirmLabel,),
                onPressed: input.isEmpty ? null : () => Navigator.pop(context, input),
              )
            ],
          )
        ],
      ),
    );
  }
}
