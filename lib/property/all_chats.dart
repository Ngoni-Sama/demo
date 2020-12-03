import 'package:flutter/material.dart';
import 'package:solo_property_app/utils/solo_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class AllChats extends StatefulWidget {
  @override
  _AllChatsState createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navyTheme,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 200,
              width: 220,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('assets/images/animated.gif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Text("No chats found!",
                    style: GoogleFonts.oswald(fontSize: 18, color: navyTheme))),
          )
        ],
      ),
    );
  }
}
