import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solo_property_app/property/chat.dart';
import 'package:solo_property_app/property/login.dart';
import 'package:solo_property_app/property/property_listing.dart';
import 'package:solo_property_app/utils/solo_theme.dart';

SharedPreferences localStorage;

class PropertyDetails extends StatefulWidget {
  static const routeName = "/property-details";
  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  getUserInfo() async {
    print("get user data IS RUNNING ");
    localStorage = await SharedPreferences.getInstance();
    print(
        "Email Id: ${localStorage.get('email')}  Password: ${localStorage.get('password')}");
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  Widget backButton() {
    return Positioned(
      top: 50.0,
      left: 20.0,
      child: FloatingActionButton(
        splashColor: Colors.white,
        backgroundColor: navyTheme,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
        ),
        mini: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3.0,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/images/car.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              backButton(),
            ],
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            color: navyTheme,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "USD 200 000",
                      style: GoogleFonts.oswald(
                          fontSize: 18,
                          color: Colors.white,
                          letterSpacing: 1.1,
                          // decoration: TextDecoration.underline,

                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Negotiable",
                      style: GoogleFonts.oswald(
                          fontSize: 16,
                          color: Colors.white,
                          letterSpacing: 1.1,
                          // decoration: TextDecoration.underline,

                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Icon(
                      Icons.info_outline,
                      size: 25,
                      color: navyTheme,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    "Description",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.oswald(
                        fontSize: 18,
                        color: navyTheme,
                        // letterSpacing: 1.1,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              left: 75.0,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Make:",
                              style: GoogleFonts.oswald(
                                  fontSize: 18,
                                  color: navyTheme,
                                  letterSpacing: 1.1,
                                  // decoration: TextDecoration.underline,

                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Mazda",
                              style: TextStyle(
                                  color: navyTheme,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Mileage:",
                              style: GoogleFonts.oswald(
                                  fontSize: 15,
                                  color: navyTheme,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "500777",
                              style: TextStyle(
                                  color: navyTheme,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Model:",
                              style: GoogleFonts.oswald(
                                  fontSize: 15,
                                  color: navyTheme,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Fit",
                              style: TextStyle(
                                  color: navyTheme,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Color:",
                              style: GoogleFonts.oswald(
                                  fontSize: 15,
                                  color: navyTheme,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Blue",
                              style: TextStyle(
                                  color: navyTheme,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Year:",
                              style: GoogleFonts.oswald(
                                  fontSize: 15,
                                  color: navyTheme,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "2020",
                              style: TextStyle(
                                  color: navyTheme,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "GearBox:",
                              style: GoogleFonts.oswald(
                                  fontSize: 15,
                                  color: navyTheme,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Auto",
                              style: TextStyle(
                                  color: navyTheme,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Icon(
                    Icons.location_on,
                    size: 25,
                    color: navyTheme,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  " Sotshangane Flats, Bulawayo",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: navyTheme,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Icon(
                    Icons.person_outline,
                    size: 25,
                    color: navyTheme,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  "ngoni",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: navyTheme,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Icon(
                    Icons.info_outline,
                    size: 30,
                    color: navyTheme,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  "Reviews",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: navyTheme,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 30.0,
              right: 30,
              top: 10,
            ),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: backgroundColor,
                ),
                SizedBox(
                  height: 3.0,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: backgroundColor,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, top: 10.0, right: 8.0),
                  child: RaisedButton(
                    animationDuration: Duration(seconds: 1000),
                    child: Text(
                      "Book Viewing",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => PropertyListing()),
                      );
                    },
                    color: navyTheme,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    splashColor: Colors.grey,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 30.0, left: 8.0, top: 10.0),
                  child: RaisedButton(
                    animationDuration: Duration(seconds: 1000),
                    child: Icon(
                      Icons.chat,
                      color: Colors.white,
                      size: 17.0,
                    ),
                    onPressed: () {
                      if (localStorage.get('email') == null &&
                          localStorage.get('password') == null) {
                        print("PRESSED");
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => SignIn(goToPage: Chat())),
                        );
                      } else {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => Chat()),
                        );
                      }
                    },
                    color: navyTheme,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    splashColor: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
