import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solo_property_app/property/property_info.dart';
import 'package:solo_property_app/property/property_listing.dart';
import 'package:solo_property_app/utils/solo_theme.dart';

class Chat extends StatefulWidget {
  // final goToPage;

  // Chat({
  //   Key key,
  //   this.goToPage,
  // });
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: navyTheme,
      //   leading: InkWell(
      //     child: Icon(
      //       Icons.arrow_back_rounded,
      //     ),
      //     onTap: () {
      //       Navigator.push(
      //         context,
      //         CupertinoPageRoute(builder: (context) => PropertyListing()),
      //       );
      //     },
      //   ),
      // ),
      body: Container(
        decoration: new BoxDecoration(
          color: navyTheme.withOpacity(0.2),
          image: new DecorationImage(
            image: new AssetImage('assets/images/animated.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            "Chat Page",
            style: simpleTextStyle(),
          ),
        ),
      ),

    );

  }
}
