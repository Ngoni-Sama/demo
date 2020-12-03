import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solo_property_app/property/property_listing.dart';
import 'package:solo_property_app/property/property_sell.dart';
import 'package:solo_property_app/utils/solo_theme.dart';
import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthMode { LOGIN, SINGUP }

SharedPreferences localStorage;

class SignIn extends StatefulWidget {
  final goToPage;

  SignIn({
    Key key,
    this.goToPage,
  });
  static const routeName = "/login";

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // To adjust the layout according to the screen size
  // so that our layout remains responsive ,we need to
  // calculate the screen height
  double screenHeight;

  String email;
  String password;
  String name;

  bool loginPressed = false;
  bool signUpPressed = false;

  void _pushPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => SignIn()),
    );
  }

  // Set intial mode to login
  AuthMode _authMode = AuthMode.LOGIN;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget pageTitle() {
    return Container(
      margin: EdgeInsets.only(top: 80, left: 25.0),
      child: Column(
        children: [
          Text(
            "Welcome",
            textAlign: TextAlign.center,
            style: GoogleFonts.oswald(fontSize: 32, color: Colors.white),
          ),
          Text(
            "please login to sell properties...",
            textAlign: TextAlign.center,
            style: whiteSmallerTextStyle(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(backgroundColor: navyTheme),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            lowerHalf(context),
            upperHalf(context),
            loginCard(context)
            // (_authMode == AuthMode.LOGIN)
            //     ? loginCard(context)
            //     : singUpCard(context),
          ],
        ),
      ),
    );
  }

  Widget loginCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 4),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                //autovalidate: _autoValidate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Login",
                        style: biggerTextStyle(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                        autofocus: true,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("email"),
                        validator: (String value) {
                          final bool isValid = EmailValidator.validate(value);
                          if (!isValid) {
                            return 'Invalid email. add @domainname.com';
                          }
                        },
                        //set state on saved
                        onSaved: (String value) {
                          email = value;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        autofocus: true,
                        obscureText: true,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("password"),
                        validator: (String value) {
                          var msg;
                          if (value.isEmpty) {
                            msg = 'Password is Required';
                          }
                          return msg;
                        },
                        //set state on saved
                        onSaved: (String value) {
                          password = value;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          child: (!loginPressed)
                              ? Text("Login")
                              : Container(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                          color: navyTheme,
                          textColor: Colors.white,
                          padding: EdgeInsets.only(
                              left: 38, right: 38, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save(); //onSaved is called!
                              setState(() {
                                loginPressed = true;
                              });
                              login(email, password);
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Don't have an account ?",
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  email = "";
                  password = "";
                });
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => SellPage()),
                );
              },
              textColor: navyTheme,
              child: Text(
                "Create Account",
                style: simpleTextStyle(),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget singUpCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 5),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Create Account",
                        style: biggerTextStyle(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: "Your Email",
                        ),
                        validator: (String value) {
                          final bool isValid = EmailValidator.validate(value);
                          if (!isValid) {
                            return 'Invalid email. add @domainname.com';
                          }
                        },
                        //set state on saved
                        onSaved: (String value) {
                          email = value;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password",
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Password required !!!';
                          }
                        },
                        //set state on saved
                        onSaved: (String value) {
                          password = value;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Password must be at least 6 characters and include a special character and number",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Container(),
                        ),
                        FlatButton(
                          child: (!signUpPressed)
                              ? Text(
                                  "Sign Up",
                                  style: whiteSmallerTextStyle(),
                                )
                              : Container(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                          color: navyTheme,
                          textColor: Colors.white,
                          padding: EdgeInsets.only(
                              left: 38, right: 38, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save(); //onSaved is called!
                              // signUp(email, password);
                              setState(() {
                                signUpPressed = true;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Already have an account?",
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  _authMode = AuthMode.LOGIN;
                });
              },
              textColor: navyTheme,
              child: Text(
                "Login",
                style: simpleTextStyle(),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FlatButton(
            child: Text(
              "Terms & Conditions",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget upperHalf(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: screenHeight / 2,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/images/realestate.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(child: Center(child: pageTitle()))
      ],
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenHeight / 2,
        color: navyTheme,
      ),
    );
  }

  void login(email, password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        //Navigator.of(context).pushReplacementNamed('/home');
        if (user != null) {
          save(); //save shared preferences
          print('DONE');
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => widget.goToPage),
          );
        }
      } catch (error) {
        switch (error.code) {
          case "ERROR_USER_NOT_FOUND":
            {
              final String errorMsg = "User not Found. Please try again.";

              setState(() {
                loginPressed = false;
              });

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        height: 100.0,
                        child: Center(
                          child: Text(errorMsg,
                              textAlign: TextAlign.center,
                              style: simpleTextStyle()),
                        ),
                      ),
                    );
                  });
            }
            break;
          case "ERROR_WRONG_PASSWORD":
            {
              final String errorMsg = "Password doesn\'t match your email.";
              setState(() {
                loginPressed = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        height: 100.0,
                        child: Center(
                          child: Text(errorMsg,
                              textAlign: TextAlign.center,
                              style: simpleTextStyle()),
                        ),
                      ),
                    );
                  });
            }
            break;
          default:
            {
              final errorMsg = "";
            }
        }
      }
    }
  }

  save() async {
    print("SAVE IS RUNNING");
    localStorage = await SharedPreferences.getInstance();
    localStorage.setString('email', email);
    localStorage.setString('password', password);
    print(
        "Email Id: ${localStorage.get('email')}  Password: ${localStorage.get('password')}");
  }
}
