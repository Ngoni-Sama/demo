import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:solo_property_app/property/property_listing.dart';
import 'package:solo_property_app/property/search_results.dart';
import 'package:solo_property_app/property/widgets/widgets.dart';
import 'package:solo_property_app/utils/solo_theme.dart';

class Rent extends StatefulWidget {
  @override
  _RentState createState() => _RentState();
}

class _RentState extends State<Rent> {
  bool isExpanded = false;

  bool isHouseSelected = false;
  bool isVehicleSelected = false;
  bool isFlatSelected = false;
  bool isBizPremiseSelected = false;
  bool isStudentAccomoSelected = false;

  String _surbubDensity;
  String _numberOfRooms;
  String _rentBudget;
  String _electricityState;
  String _waterAvailability;

  String _carMake;
  String _carMileage;
  String _carTransmission;
  String _carBudget;
  String _carYear;
  String _carColor;
  String _carFuel;
  String _busSeats;

  String selectedProperty;

  Position currentLocation;

  var numberOfPosts;
  List posts;

  var dbRef = Firestore.instance;
  List allListings = [];

  Future getLive() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation)
        .then((Position position) {
      //logic code goes here
      // addLocation(position);
      setState(() {
        currentLocation = position;
      });
      print(currentLocation);
    }).catchError((dynamic e) {
      print(e);
    });
  }

  @override
  void initState() {
    getLive();
    setState(() {
      allListings = [];
    });
    super.initState();
  }

  Widget _rentHouse() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 15.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    "Surbub",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
              Expanded(
                  flex: 3,
                  child: DropdownButton(
                    hint: _surbubDensity == null
                        ? Text('select one')
                        : Text(
                            _surbubDensity,
                            style: TextStyle(color: navyTheme),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: navyTheme),
                    items: [
                      'High Density',
                      'Medium Density',
                      'Low DEnsity',
                    ].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _surbubDensity = val;
                        },
                      );
                    },
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 15.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    " No. of Rooms",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
              Expanded(
                flex: 3,
                child: DropdownButton(
                  hint: _numberOfRooms == null
                      ? Text('select one')
                      : Text(
                          _numberOfRooms,
                          style: TextStyle(color: navyTheme),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: navyTheme),
                  items: ['2', '3', '4', '5', '6', '7', '8', '9', '10'].map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _numberOfRooms = val;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 15.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    "Budget",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
              Expanded(
                flex: 3,
                child: DropdownButton(
                  hint: _rentBudget == null
                      ? Text('choose budget')
                      : Text(
                          _rentBudget,
                          style: TextStyle(color: navyTheme),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: navyTheme),
                  items: [
                    '0 - 1000',
                    '1000 - 2500',
                    '2500 - 7000',
                  ].map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _rentBudget = val;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        isExpanded
            ? new Container(
                width: MediaQuery.of(context).size.width - 100.0,
                height: 120,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                "Electricity",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                          Expanded(
                            flex: 3,
                            child: DropdownButton(
                              hint: _electricityState == null
                                  ? Text('select one')
                                  : Text(
                                      _electricityState,
                                      style: TextStyle(color: navyTheme),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: navyTheme),
                              items: [
                                'pre-paid',
                                'fixed',
                                'metered',
                                'no power'
                              ].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _electricityState = val;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                "Water",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                          Expanded(
                            flex: 3,
                            child: DropdownButton(
                              hint: _waterAvailability == null
                                  ? Text('select one')
                                  : Text(
                                      _waterAvailability,
                                      style: TextStyle(color: navyTheme),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: navyTheme),
                              items: [
                                'Metered',
                                "No-water",
                              ].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _waterAvailability = val;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              )
            : SizedBox(),
        isExpanded == false
            ? Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: RaisedButton(
                        child: Text("Search", style: whiteSmallerTextStyle()),
                        onPressed: () {
                          getAllListings(7);
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    SearchResults(allListings: allListings)),
                          );
                        },
                        color: navyTheme,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        splashColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: new FlatButton(
                      child: const Text(
                        'Show More',
                        style: TextStyle(color: Color(0xF5404B60)),
                      ),
                      onPressed: () => setState(() => isExpanded = true),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: RaisedButton(
                        child: Text("Search", style: whiteSmallerTextStyle()),
                        onPressed: () {
                          getAllListings(7);
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    SearchResults(allListings: allListings)),
                          );
                        },
                        color: navyTheme,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        splashColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: new FlatButton(
                      child: const Text(
                        'Show Less',
                        style: TextStyle(color: Color(0xF5404B60)),
                      ),
                      onPressed: () => setState(() => isExpanded = false),
                    ),
                  ),
                ],
              )
      ],
    );
  }

  Widget _rentFlat() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 15.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    "Location",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
              Expanded(
                  flex: 3,
                  child: DropdownButton(
                    hint: _surbubDensity == null
                        ? Text('select one')
                        : Text(
                            _surbubDensity,
                            style: TextStyle(color: navyTheme),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: navyTheme),
                    items: [
                      'CBD',
                      'form input',
                      'Low DEnsity',
                    ].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _surbubDensity = val;
                        },
                      );
                    },
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 15.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    "Rooms",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
              Expanded(
                flex: 3,
                child: DropdownButton(
                  hint: _numberOfRooms == null
                      ? Text('select one')
                      : Text(
                          _numberOfRooms,
                          style: TextStyle(color: navyTheme),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: navyTheme),
                  items: ['2', '3', '4', '5', '6', '7', '8', '9', '10'].map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _numberOfRooms = val;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 15.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    "Budget",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
              Expanded(
                flex: 3,
                child: DropdownButton(
                  hint: _rentBudget == null
                      ? Text('choose budget')
                      : Text(
                          _rentBudget,
                          style: TextStyle(color: navyTheme),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: navyTheme),
                  items: [
                    '0 - 1000',
                    '1000 - 2500',
                    '2500 - 7000',
                  ].map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _rentBudget = val;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        isExpanded
            ? new Container(
                width: MediaQuery.of(context).size.width - 100.0,
                height: 120,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                "To Share",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                          Expanded(
                            flex: 3,
                            child: DropdownButton(
                              hint: _electricityState == null
                                  ? Text('select one')
                                  : Text(
                                      _electricityState,
                                      style: TextStyle(color: navyTheme),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: navyTheme),
                              items: [
                                'Yes',
                                'No',
                              ].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _electricityState = val;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                "Bedrooms",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                          Expanded(
                            flex: 3,
                            child: DropdownButton(
                              hint: _waterAvailability == null
                                  ? Text('select one')
                                  : Text(
                                      _waterAvailability,
                                      style: TextStyle(color: navyTheme),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: navyTheme),
                              items: [
                                'Any',
                              ].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _waterAvailability = val;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              )
            : SizedBox(),
        isExpanded == false
            ? Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: RaisedButton(
                        child: Text("Search", style: whiteSmallerTextStyle()),
                        onPressed: () {
                          getAllListings(9);
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    SearchResults(allListings: allListings)),
                          );
                        },
                        color: navyTheme,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        splashColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: new FlatButton(
                      child: const Text(
                        'Show More',
                        style: TextStyle(color: Color(0xF5404B60)),
                      ),
                      onPressed: () => setState(() => isExpanded = true),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: RaisedButton(
                        child: Text("Search", style: whiteSmallerTextStyle()),
                        onPressed: () {
                          getAllListings(9);
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    SearchResults(allListings: allListings)),
                          );
                        },
                        color: navyTheme,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        splashColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: new FlatButton(
                      child: const Text(
                        'Show Less',
                        style: TextStyle(color: Color(0xF5404B60)),
                      ),
                      onPressed: () => setState(() => isExpanded = false),
                    ),
                  ),
                ],
              )
      ],
    );
  }

  Widget _rentBusinessPremise() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 15.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    "Location",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
              Expanded(
                  flex: 3,
                  child: DropdownButton(
                    hint: _surbubDensity == null
                        ? Text('select one')
                        : Text(
                            _surbubDensity,
                            style: TextStyle(color: navyTheme),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: navyTheme),
                    items: [
                      'form input',
                      'CBD',
                    ].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _surbubDensity = val;
                        },
                      );
                    },
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 15.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    "Rooms",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
              Expanded(
                flex: 3,
                child: DropdownButton(
                  hint: _numberOfRooms == null
                      ? Text('select one')
                      : Text(
                          _numberOfRooms,
                          style: TextStyle(color: navyTheme),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: navyTheme),
                  items: ['2', '3', '4', '5', '6', '7', '8', '9', '10'].map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _numberOfRooms = val;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 15.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    "To Share",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
              Expanded(
                flex: 3,
                child: DropdownButton(
                  hint: _rentBudget == null
                      ? Text('any')
                      : Text(
                          _rentBudget,
                          style: TextStyle(color: navyTheme),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: navyTheme),
                  items: ['Yes', 'No'].map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _rentBudget = val;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        isExpanded
            ? new Container(
                width: MediaQuery.of(context).size.width - 100.0,
                height: 120,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                "Kitchen",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                          Expanded(
                            flex: 3,
                            child: DropdownButton(
                              hint: _electricityState == null
                                  ? Text('select one')
                                  : Text(
                                      _electricityState,
                                      style: TextStyle(color: navyTheme),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: navyTheme),
                              items: [
                                'Yes',
                                'No',
                              ].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _electricityState = val;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                "Bathroom",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                          Expanded(
                            flex: 3,
                            child: DropdownButton(
                              hint: _waterAvailability == null
                                  ? Text('select one')
                                  : Text(
                                      _waterAvailability,
                                      style: TextStyle(color: navyTheme),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: navyTheme),
                              items: ['Any', 'Many'].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _waterAvailability = val;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              )
            : SizedBox(),
        isExpanded == false
            ? Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: RaisedButton(
                        child: Text("Search", style: whiteSmallerTextStyle()),
                        onPressed: () {
                          getAllListings(8);
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    SearchResults(allListings: allListings)),
                          );
                        },
                        color: navyTheme,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        splashColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: new FlatButton(
                      child: const Text(
                        'Show More',
                        style: TextStyle(color: Color(0xF5404B60)),
                      ),
                      onPressed: () => setState(() => isExpanded = true),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: RaisedButton(
                        child: Text("Search", style: whiteSmallerTextStyle()),
                        onPressed: () {
                          getAllListings(8);
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    SearchResults(allListings: allListings)),
                          );
                        },
                        color: navyTheme,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        splashColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: new FlatButton(
                      child: const Text(
                        'Show Less',
                        style: TextStyle(color: Color(0xF5404B60)),
                      ),
                      onPressed: () => setState(() => isExpanded = false),
                    ),
                  ),
                ],
              )
      ],
    );
  }

  Widget _rentVehicle() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 15.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    "Make",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
              Expanded(
                  flex: 3,
                  child: DropdownButton(
                    hint: _carMake == null
                        ? Text('select one')
                        : Text(
                            _carMake,
                            style: TextStyle(color: navyTheme),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: navyTheme),
                    items:
                        ['Toyota', 'Nissan', 'Mazda', 'Datsun', 'Pegueot'].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _carMake = val;
                        },
                      );
                    },
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 15.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    "Transmission",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
              Expanded(
                flex: 3,
                child: DropdownButton(
                  hint: _carTransmission == null
                      ? Text('select one')
                      : Text(
                          _carTransmission,
                          style: TextStyle(color: navyTheme),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: navyTheme),
                  items: [
                    'Any',
                    'Manual',
                    'Automatic',
                  ].map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _carTransmission = val;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 15.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    "Budget",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
              Expanded(
                flex: 3,
                child: DropdownButton(
                  hint: _carBudget == null
                      ? Text('choose budget')
                      : Text(
                          _carBudget,
                          style: TextStyle(color: navyTheme),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: navyTheme),
                  items: [
                    '0 - 1000',
                    '1000 - 2500',
                    '2500 - 7000',
                  ].map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _carBudget = val;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        isExpanded
            ? new Container(
                width: MediaQuery.of(context).size.width - 100.0,
                height: 170,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                "Year",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                          Expanded(
                            flex: 3,
                            child: DropdownButton(
                              hint: _carYear == null
                                  ? Text('choose year')
                                  : Text(
                                      _carYear,
                                      style: TextStyle(color: navyTheme),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: navyTheme),
                              items: [
                                '1990 - 1999',
                                '2000 - 2005',
                                '2006 - 2010',
                                '2011 - 2016',
                                '2016 - 2020'
                              ].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _carYear = val;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                "Color",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                          Expanded(
                            flex: 3,
                            child: DropdownButton(
                              hint: _carColor == null
                                  ? Text('choose color')
                                  : Text(
                                      _carColor,
                                      style: TextStyle(color: navyTheme),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: navyTheme),
                              items: [
                                'black',
                                "white",
                                'red',
                                'yellow',
                                'blue',
                                'green'
                              ].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _carColor = val;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                "Fuel",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                          Expanded(
                            flex: 3,
                            child: DropdownButton(
                              hint: _carFuel == null
                                  ? Text('choose fuel')
                                  : Text(
                                      _carFuel,
                                      style: TextStyle(color: navyTheme),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: navyTheme),
                              items: [
                                'Diesel',
                                "Petrol",
                                'Hydro',
                              ].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _carFuel = val;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox(),
        isExpanded == false
            ? Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: RaisedButton(
                        child: Text("Search", style: whiteSmallerTextStyle()),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    SearchResults(allListings: allListings)),
                          );
                        },
                        color: navyTheme,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        splashColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: new FlatButton(
                      child: const Text(
                        'Show More',
                        style: TextStyle(color: Color(0xF5404B60)),
                      ),
                      onPressed: () => setState(() => isExpanded = true),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: RaisedButton(
                        child: Text("Search", style: whiteSmallerTextStyle()),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    SearchResults(allListings: allListings)),
                          );
                        },
                        color: navyTheme,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        splashColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: new FlatButton(
                      child: const Text(
                        'Show Less',
                        style: TextStyle(color: Color(0xF5404B60)),
                      ),
                      onPressed: () => setState(() => isExpanded = false),
                    ),
                  ),
                ],
              )
      ],
    );
  }

  Widget _buildWidgetToShow() {
    Widget _widgetTobeDisplayed;

    if (selectedProperty == "House") {
      _widgetTobeDisplayed = _rentHouse();
    } else if (selectedProperty == "Flat/Apartment") {
      _widgetTobeDisplayed = _rentFlat();
    } else if (selectedProperty == "Business Premise") {
      _widgetTobeDisplayed = _rentBusinessPremise();
    } else if (selectedProperty == "Student Accomo") {
      _widgetTobeDisplayed = _rentHouse();
    }

    return _widgetTobeDisplayed;
  }

  Widget _buildPropertyChoice() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 50.0, bottom: 80.0, right: 280.0),
            child: FloatingActionButton(
              splashColor: Colors.white,
              backgroundColor: navyTheme,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => PropertyListing()),
                );
              },
              child: Icon(
                Icons.arrow_back,
              ),
              mini: true,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.6,
            height: 50.0,
            child: RaisedButton(
              child: Text("House"),
              onPressed: () {
                setState(() {
                  isHouseSelected = true;
                  selectedProperty = "House";
                });
              },
              color: Colors.white,
              textColor: navyTheme,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              splashColor: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.6,
            height: 50.0,
            child: RaisedButton(
              child: Text("Flat/Apartment"),
              onPressed: () {
                if (isFlatSelected == false) {
                  setState(() {
                    isFlatSelected = true;
                    selectedProperty = "Flat/Apartment";
                  });
                } else {
                  setState(() {
                    isFlatSelected = false;
                    selectedProperty = "";
                  });
                }
              },
              color: Colors.white,
              textColor: navyTheme,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              splashColor: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.6,
            height: 50.0,
            child: RaisedButton(
              child: Text("Business Premise"),
              onPressed: () {
                if (isBizPremiseSelected == false) {
                  setState(() {
                    isBizPremiseSelected = true;
                    selectedProperty = "Business Premise";
                  });
                } else {
                  setState(() {
                    isBizPremiseSelected = false;
                    selectedProperty = "";
                  });
                }
              },
              color: Colors.white,
              textColor: navyTheme,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              splashColor: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.6,
            height: 50.0,
            child: RaisedButton(
              child: Text("Student Accomo"),
              onPressed: () {
                if (isStudentAccomoSelected == false) {
                  setState(() {
                    isStudentAccomoSelected = true;
                    selectedProperty = "Student Accomo";
                  });
                } else {
                  setState(() {
                    isStudentAccomoSelected = false;
                    selectedProperty = "";
                  });
                }
              },
              color: Colors.white,
              textColor: navyTheme,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              splashColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterWidget(String propertyName) {
    return new Column(
      children: <Widget>[
        new ConstrainedBox(
          constraints: isExpanded
              ? new BoxConstraints()
              : new BoxConstraints(
                  maxHeight: (isHouseSelected = true)
                      ? MediaQuery.of(context).size.height / 2.5
                      : MediaQuery.of(context).size.height / 2.1),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            width: MediaQuery.of(context).size.width - 100.0,
            height: (selectedProperty == "Vehicle")
                ? MediaQuery.of(context).size.height / 1.55
                : MediaQuery.of(context).size.height / 1.75,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FlatButton.icon(
                      color: Colors.white,
                      splashColor: themeColor,
                      onPressed: () {
                        setState(() {
                          isHouseSelected = false;
                          isVehicleSelected = false;
                          isFlatSelected = false;
                          isStudentAccomoSelected = false;
                          isBizPremiseSelected = false;
                        });
                        print(isHouseSelected);
                        print(isFlatSelected);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: navyTheme,
                      ),
                      label: Text(
                        "",
                      ),
                    ),
                    (isHouseSelected == true ||
                            isVehicleSelected == true ||
                            isFlatSelected == true)
                        ? new Text(
                            propertyName + " " + "to rent",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: navyTheme,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                        : Center(
                            child: new Text(
                              propertyName,
                              style: TextStyle(
                                  color: navyTheme,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 6.0,
                ),
                _buildWidgetToShow()
              ],
            ),
          ),
        ),
      ],
    );
  }

  void getAllListings(sellType) async {
    print("FETCHING $sellType ");
    await dbRef
        .collection("listings")
        .where('sellType', isEqualTo: sellType)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      setState(() {
        numberOfPosts = snapshot.documents.length;
        posts = snapshot.documents;
      });

      posts.forEach((f) => {
            allListings.add(
              f.data,
            ),
          });
      print(allListings);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        currentLocation == null
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: navyTheme.withOpacity(0.4),
              )
            : Map(
                position: currentLocation,
              ),
        (isHouseSelected == false &&
                isFlatSelected == false &&
                isVehicleSelected == false &&
                isStudentAccomoSelected == false &&
                isBizPremiseSelected == false)
            ? Positioned(top: 10.0, child: _buildPropertyChoice())
            : Positioned(
                top: 10.0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.withOpacity(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_buildFilterWidget(selectedProperty)],
                  ),
                ),
              ),
      ],
    );
  }
}
