import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solo_property_app/property/posting_options.dart';

import 'package:solo_property_app/utils/solo_theme.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

final dobController = new MaskedTextController(mask: '00-00-0000');
final idNumController = new MaskedTextController(mask: '00-000000-A00');
final phoneController = new MaskedTextController(mask: '00-000000-A00');

GlobalKey<FormState> _formKey = GlobalKey();
SharedPreferences localStorage;
String accountType;
bool isUploadingPost = false;

class RegistrationData {
  String name;
  String regNumber;
  dynamic phone;
  String dob;
  String address;
  String city;

  String idNumber;
  String companyName;
  String companyReg;
  dynamic experience;

  String history;
  String companyDescription;
  String email;
  String password;
}

class StepperBody extends StatefulWidget {
  @override
  _StepperBodyState createState() => new _StepperBodyState();
}

class _StepperBodyState extends State<StepperBody> {
  int currStep = 0;
  // static var _focusNode = new FocusNode();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static RegistrationData data = new RegistrationData();
  Position currentLocation;

  List<Step> steps = [
    new Step(
      title: const Text(
        'Personal Details',
      ),
      //subtitle: const Text('Enter your name'),
      isActive: true,
      //state: StepState.error,
      state: StepState.indexed,
      content: Column(
        children: [
          new TextFormField(
            keyboardType: TextInputType.text,
            autocorrect: false,
            onSaved: (String value) {
              data.name = value;
            },
            maxLines: 1,
            //initialValue: 'Aseem Wangoo',
            validator: (value) {
              if (value.isEmpty || value.length < 1) {
                return 'Please enter name';
              }
            },
            style: simpleTextStyle(),
            decoration: textFieldInputDecoration("FullName"),
          ),
          SizedBox(
            height: 20,
          ),
          new TextFormField(
            maxLength: 14,
            controller: idNumController,
            style: simpleTextStyle(),
            decoration: textFieldInputDecoration("ID number"),
            validator: (value) {
              if (value.isEmpty) {
                return 'ID incorrect';
              }
            },
            onSaved: (String value) {
              data.idNumber = value;
            },
          ),
          new TextFormField(
            keyboardType: TextInputType.number,
            maxLength: 10,
            controller: dobController,
            style: simpleTextStyle(),
            decoration: textFieldInputDecoration("Date of birth"),
            validator: (value) {
              if (value.isEmpty || value.length < 10) {
                return 'd.o.b incorrect. try DD/MM/YYY';
              }
            },
            onSaved: (String value) {
              data.dob = value;
            },
          )
        ],
      ),
    ),
    new Step(
      title: const Text('Account Details'),
      //subtitle: const Text('Subtitle'),
      isActive: true,
      //state: StepState.editing,
      state: StepState.indexed,
      content: Column(
        children: [
          TextFormField(
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration("Email"),
              validator: (String value) {
                final bool isValid = EmailValidator.validate(value);
                if (!isValid) {
                  return 'Invalid email. add @domainname.com';
                }
              },
              //set state on saved
              onSaved: (String value) {
                data.email = value;
              }),
          SizedBox(height: 8.0),
          TextFormField(
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration("Password"),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Password required !!!';
                }
              },
              //set state on saved
              onSaved: (String value) {
                data.password = value;
              }),
          SizedBox(height: 8.0),
          new TextFormField(
            keyboardType: TextInputType.number,
            autocorrect: false,
            onSaved: (value) {
              data.phone = value;
            },
            maxLines: 1,
            //initialValue: 'Aseem Wangoo',
            validator: (value) {
              if (value.isEmpty || value.length < 10) {
                return 'Please enter valid phone number';
              }
            },
            style: simpleTextStyle(),
            decoration: textFieldInputDecoration("Phone number"),
          ),
          SizedBox(
            height: 8.0,
          ),
          new TextFormField(
            keyboardType: TextInputType.number,
            style: simpleTextStyle(),
            decoration: textFieldInputDecoration("Years of experience"),
            onSaved: (value) {
              data.experience = value;
            },
          ),
          SizedBox(
            height: 8.0,
          ),
          new TextFormField(
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            maxLength: 250,
            style: simpleTextStyle(),
            decoration: textFieldInputDecoration("Work History"),
            validator: (value) {
              if (value.isEmpty) {
                return 'field can not be empty';
              }
            },
            onSaved: (String value) {
              data.history = value;
            },
          ),
        ],
      ),
    ),
    Step(
        title: const Text('Company Details'),
        isActive: true,
        state: StepState.indexed,
        content: (accountType != "Individual" ||
                accountType != "Mechanic" ||
                accountType != "Consultant")
            ? SizedBox(
                height: 30.0,
                child: Text(
                  "Choose business account to add business details",
                  style: simpleTextStyle(),
                ),
              )
            : Column(
                children: [
                  new TextFormField(
                    style: simpleTextStyle(),
                    decoration: textFieldInputDecoration("Company Name"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'company name can not be empty';
                      }
                    },
                    onSaved: (String value) {
                      data.companyName = value;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  new TextFormField(
                    style: simpleTextStyle(),
                    decoration: textFieldInputDecoration("Registration #"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'registration can not be empty';
                      }
                    },
                    onSaved: (String value) {
                      data.companyReg = value;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  new TextFormField(
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    maxLength: 80,
                    style: simpleTextStyle(),
                    decoration: textFieldInputDecoration("Company description"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'field can not be empty';
                      }
                    },
                    onSaved: (String value) {
                      data.companyDescription = value;
                    },
                  ),
                ],
              )),
  ];

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Form(
      key: _formKey,
      child: new ListView(children: <Widget>[
        new Stepper(
          steps: steps,
          type: StepperType.vertical,
          currentStep: this.currStep,
          onStepContinue: () {
            setState(() {
              if (currStep < steps.length - 1) {
                currStep = currStep + 1;
              } else {
                currStep = 0;
              }
              // else {
              // Scaffold
              //     .of(context)
              //     .showSnackBar(new SnackBar(content: new Text('$currStep')));

              // if (currStep == 1) {
              //   print('First Step');
              //   print('object' + FocusScope.of(context).toStringDeep());
              // }

              // }
            });
          },
          onStepCancel: () {
            setState(() {
              if (currStep > 0) {
                currStep = currStep - 1;
              } else {
                currStep = 0;
              }
            });
          },
          onStepTapped: (step) {
            setState(() {
              currStep = step;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: new RaisedButton(
            child: isUploadingPost == false
                ? new Text(
                    'Save details',
                    style: new TextStyle(color: Colors.white),
                  )
                : Text(
                    'Saving details...',
                    style: new TextStyle(color: Colors.white),
                  ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save(); //onSaved is called!
                createNewAccount(data.email, data.password);
              }
            },
            color: navyTheme,
          ),
        ),
      ]),
    ));
  }

  saveRegDetailsLocally() async {
    localStorage = await SharedPreferences.getInstance();
    localStorage.setString('email', data.email);
    localStorage.setString('password', data.password);
    print("Email and password SAVED");
  }

  getCity() async {
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    setState(() {
      data.city = placemark[0].subAdministrativeArea;
    });
  }

  void submitRegDetails() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    final Firestore myDatabase = Firestore.instance;
    final Geoflutterfire geo = Geoflutterfire();

    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation)
        .then((Position position) {
      setState(() {
        currentLocation = position;
      });

      GeoFirePoint userLocation =
          geo.point(latitude: position.latitude, longitude: position.longitude);

      //logic code goes here
      print("UPLOADING TO USERS PAGE");
      if (isUploadingPost == false &&
          currentLocation != null &&
          data.city != null) {
        myDatabase.collection('users').document().setData({
          'userEmail': data.email,
          'location': userLocation.data,
          'name': data.name,
          'account_type': accountType,
          'identity_number': data.idNumber,
          'd.o.b': data.dob,
          'time': DateTime.now(),
          'city': data.city
        });
      }
    }).catchError((dynamic e) {
      print(e);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: 100.0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(e,
                        textAlign: TextAlign.center, style: simpleTextStyle()),
                  ),
                ),
              ),
            );
          });
    });
  }

  createNewAccount(email, password) async {
    localStorage = await SharedPreferences.getInstance();

    if (password != null && email != null) {
      setState(() {
        isUploadingPost = true;
      });
      saveRegDetailsLocally();
      try {
        AuthResult user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        print(user);

        submitRegDetails();
        showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text("$accountType account created"),
            //content: new Text("Hello World"),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new Text("Name: " + data.name),
                  new Text("DOB: " + data.email),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                children: [
                  // new FlatButton(
                  //   child: new Text('Edit'),
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //   },
                  // ),
                  new FlatButton(
                    child: new Text(
                      'Continue',
                      style: simpleTextStyle(),
                    ),
                    onPressed: () {
                      submitRegDetails();
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => PostingOptions()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      } catch (error) {
        switch (error.code) {
          case 'ERROR_EMAIL_ALREADY_IN_USE':
            {
              localStorage.setString('email', '');
              localStorage.setString('password', '');
              setState(() {
                isUploadingPost = false;
              });
              const errorMsg = 'This email is already in use.';

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        height: 100.0,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(errorMsg,
                                textAlign: TextAlign.center,
                                style: simpleTextStyle()),
                          ),
                        ),
                      ),
                    );
                  });
            }
            break;
          case 'ERROR_WEAK_PASSWORD':
            {
              const errorMsg =
                  'The password must be 6 characters long or more.';
              localStorage.setString('email', '');
              localStorage.setString('password', '');
              setState(() {
                isUploadingPost = false;
              });

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        height: 100.0,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(errorMsg,
                                textAlign: TextAlign.center,
                                style: simpleTextStyle()),
                          ),
                        ),
                      ),
                    );
                  });
            }
            break;
          default:
            {
              dynamic errorMsg;
              errorMsg = "";
            }
        }
      }
    }
  }
}

class SellerRegistration extends StatefulWidget {
  final typeOfAccount;
  SellerRegistration({this.typeOfAccount});

  @override
  _SellerRegistrationState createState() => _SellerRegistrationState();
}

class _SellerRegistrationState extends State<SellerRegistration> {
  int currentStep = 0;
  static RegistrationData data = new RegistrationData();
  bool complete = false;

  @override
  void initState() {
    setState(() {
      accountType = widget.typeOfAccount;
    });
    print("ACCOUNT SELECTED IS: " + accountType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: navyTheme,
          title: Text("Create ${widget.typeOfAccount} Account",
              style: whiteBiggerTextStyle())),
      body: StepperBody(),
    );
  }
}
