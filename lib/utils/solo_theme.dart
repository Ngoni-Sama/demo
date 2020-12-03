import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color themeColor = Color(0xF5404B60);

Color navyTheme = Color(0xff083663); //AstronautBLue

Color textLabelColor = Colors.grey;
Color unselectedIconColor = Colors.grey[500];
Color backgroundColor = Colors.grey[200];

TextStyle simpleTextStyle() {
  return GoogleFonts.oswald(fontSize: 15, color: navyTheme);
}

TextStyle smallTextStyle() {
  return GoogleFonts.oswald(fontSize: 13, color: navyTheme);
}



TextStyle underlineSmallTextStyle() {
  return GoogleFonts.oswald(
      fontSize: 13, color: navyTheme, decoration: TextDecoration.underline);
}

TextStyle biggerTextStyle() {
  return GoogleFonts.oswald(fontSize: 22, color: navyTheme);
}

TextStyle whiteSmallerTextStyle() {
  return GoogleFonts.oswald(fontSize: 15, color: Colors.white);
}

TextStyle whiteBiggerTextStyle() {
  return GoogleFonts.oswald(fontSize: 22, color: Colors.white);
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: navyTheme.withOpacity(0.7), width: 2.0),
    ),
    hintText: hintText,
    // prefixIcon: Icon(Icons.mail_outline),
  );
}
