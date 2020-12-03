

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:solo_property_app/property/login.dart';
import 'package:solo_property_app/property/post_property.dart';
import 'package:solo_property_app/property/property_info.dart';
import 'package:solo_property_app/property/search_results.dart';
import 'property/property_listing.dart';
import 'property/property_sell.dart';




FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
  //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //       new FlutterLocalNotificationsPlugin();

  //   // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  //   var initializationSettingsAndroid =
  //       AndroidInitializationSettings('mipmap/ic_launcher');
  //   var initializationSettingsIOS = IOSInitializationSettings(
  //       onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  //   var initializationSettings = InitializationSettings();
  //   flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onSelectNotification: onSelectNotification);
  // }

  // Future<void> onSelectNotification(String payload) async {
  //   if (payload != null) {
  //     debugPrint('notification payload: ' + payload);
  //   }

  //   await Navigator.push(
  //     context,
  //     CupertinoPageRoute(builder: (context) => PropertySell()),
  //   );
  // }

  // Future<void> onDidReceiveLocalNotification(
  //     int id, String title, String body, String payload) async {
  //   // display a dialog with the notification details, tap ok to go to another page
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) => CupertinoAlertDialog(
  //       title: title != null ? Text(title) : null,
  //       content: body != null ? Text(body) : null,
  //       actions: [
  //         CupertinoDialogAction(
  //           isDefaultAction: true,
  //           child: Text('Ok'),
  //           onPressed: () async {
  //             Navigator.of(context, rootNavigator: true).pop();
  //             await Navigator.push(
  //               context,
  //               CupertinoPageRoute(
  //                 builder: (context) => PropertySell(),
  //               ),
  //             );
  //           },
  //         )
  //       ],
  //     ),
  //   );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Solo App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: PropertyListing(),
      routes: {
        PropertySell.routeName: (context) => SellPage(), //PropertySell(),
        PropertyListing.routeName: (context) => PropertyListing(),
        SearchResults.routeName: (context) => SearchResults(),
        PropertyDetails.routeName: (context) => PropertyDetails(),
        SignIn.routeName: (context) => SignIn()
      },
    );
  }
}





