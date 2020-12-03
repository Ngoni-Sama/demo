import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.btnText, @required this.onPressed});

  final String btnText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Color(0xff083663),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 100.0,
          height: 40.0,
          child: Text(
            btnText,
            style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
