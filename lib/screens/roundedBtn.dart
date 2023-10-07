import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.text = "", this.screenId, this.color});

  final String text;
  final dynamic screenId;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: () {
            Navigator.pushNamed(context, screenId);
          },
          minWidth: 300.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
