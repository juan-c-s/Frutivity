import 'package:flutter/material.dart';

class LogInButton extends StatelessWidget {
  LogInButton(
      {@required this.color,
      @required this.onPressed,
      @required this.text,
      @required this.textColor});
  final Color color;
  final Function onPressed;
  final String text;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
