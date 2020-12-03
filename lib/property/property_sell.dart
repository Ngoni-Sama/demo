import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:solo_property_app/property/seller_reg.dart';

import '../utils/solo_theme.dart';

SharedPreferences localStorage;

class SellPage extends StatefulWidget {
  static const routeName = "/sell";
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  String chosenAccountType = '';

  getUserInfo() async {
    localStorage = await SharedPreferences.getInstance();
    print("get user data IS RUNNING ");

    print(
        "Email Id: ${localStorage.get('email')}  Password: ${localStorage.get('password')}");
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: navyTheme,
          title: Text("", style: whiteBiggerTextStyle())),
      body: Container(
        decoration: new BoxDecoration(
          color: navyTheme.withOpacity(0.2),
          image: new DecorationImage(
            image: new AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 20.0, left: 30.0, right: 30.0, top: 150.0),
              child: Text(
                "Hi, please choose one type of account below to start selling",
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(
                    fontSize: 17,
                    color: navyTheme,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: RaisedButton(
                      animationDuration: Duration(seconds: 1000),
                      child: Text("Individual",
                          style: GoogleFonts.oswald(
                              fontSize: 14,
                              color: chosenAccountType == "Individual"
                                  ? Colors.white
                                  : navyTheme,
                              letterSpacing: 1.1,
                              // decoration: TextDecoration.underline,

                              fontWeight: FontWeight.w500)),
                      onPressed: () {
                        setState(() {
                          chosenAccountType = "Individual";
                        });
                        goToUserRegistrationPage();
                      },
                      color: chosenAccountType == "Individual"
                          ? navyTheme
                          : Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      splashColor: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: RaisedButton(
                      animationDuration: Duration(seconds: 1000),
                      child: Text(
                        "Mechanic",
                        style: GoogleFonts.oswald(
                            fontSize: 14,
                            color: chosenAccountType == "Mechanic"
                                ? Colors.white
                                : navyTheme,
                            letterSpacing: 1.1,
                            // decoration: TextDecoration.underline,

                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        setState(() {
                          chosenAccountType = "Mechanic";
                        });
                        goToUserRegistrationPage();
                      },
                      color: chosenAccountType == "Mechanic"
                          ? navyTheme
                          : Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      splashColor: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 30.0,
                    ),
                    child: RaisedButton(
                      animationDuration: Duration(seconds: 1000),
                      child: Text(
                        "Consultant",
                        style: GoogleFonts.oswald(
                            fontSize: 14,
                            color: chosenAccountType == "Consultant"
                                ? Colors.white
                                : navyTheme,
                            letterSpacing: 1.1,
                            // decoration: TextDecoration.underline,

                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        setState(() {
                          chosenAccountType = "Consultant";
                        });
                        goToUserRegistrationPage();
                      },
                      color: chosenAccountType == "Consultant"
                          ? navyTheme
                          : Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      splashColor: Colors.grey,
                    ),
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
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 5.0),
                    child: RaisedButton(
                      animationDuration: Duration(seconds: 1000),
                      child: Text(
                        "Car Dealer",
                        style: GoogleFonts.oswald(
                            fontSize: 14,
                            color: chosenAccountType == "Car Dealer"
                                ? Colors.white
                                : navyTheme,
                            letterSpacing: 1.1,
                            // decoration: TextDecoration.underline,

                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        setState(() {
                          chosenAccountType = "Car Dealer";
                        });
                        goToUserRegistrationPage();
                      },
                      color: chosenAccountType == "Car Dealer"
                          ? navyTheme
                          : Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      splashColor: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30.0, left: 5.0),
                    child: RaisedButton(
                      animationDuration: Duration(seconds: 1000),
                      child: Text(
                        "Estate Agency",
                        style: GoogleFonts.oswald(
                            fontSize: 14,
                            color: chosenAccountType == "Estate Agency"
                                ? Colors.white
                                : navyTheme,
                            letterSpacing: 1.1,
                            // decoration: TextDecoration.underline,

                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        setState(() {
                          chosenAccountType = "Estate Agency";
                        });
                        goToUserRegistrationPage();
                      },
                      color: chosenAccountType == "Estate Agency"
                          ? navyTheme
                          : Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      splashColor: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void goToUserRegistrationPage() {
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => SellerRegistration(
                typeOfAccount: chosenAccountType,
              )),
    );
  }
}
