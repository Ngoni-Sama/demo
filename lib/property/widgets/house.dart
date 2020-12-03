import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:solo_property_app/property/property_listing.dart';
import 'package:solo_property_app/property/search_results.dart';
import 'package:solo_property_app/property/widgets/widgets.dart';
import 'package:solo_property_app/utils/solo_theme.dart';
import 'package:latlong/latlong.dart';

class House extends StatefulWidget {
  @override
  _HouseState createState() => _HouseState();
}

class _HouseState extends State<House> {
  String selectedProperty;

  bool isExpanded = false;

  bool isBizPremiseSelected = false;
  bool isStudentAccomoSelected = false;

  bool isResidentialHouseSelected = false;
  bool isCormmecialBuildingSelected = false;
  bool isFlatSelected = false;

  String _standSize;
  String _numberOfRooms;
  String _rentBudget;
  String _electricityState;
  String _waterAvailability;

  var email;
  var name;
  var accountType;
  var numberOfPosts;
  List posts;

  var dbRef = Firestore.instance;
  List allListings = [];

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

  Widget _residentialHouse() {
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
                    hint: _standSize == null
                        ? Text('select one')
                        : Text(
                            _standSize,
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
                          _standSize = val;
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
                    "Surbub",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
              Expanded(
                  flex: 3,
                  child: DropdownButton(
                    hint: _standSize == null
                        ? Text('select one')
                        : Text(
                            _standSize,
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
                          _standSize = val;
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
                                "Stand size",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                          Expanded(
                              flex: 3,
                              child: DropdownButton(
                                hint: _standSize == null
                                    ? Text('select one')
                                    : Text(
                                        _standSize,
                                        style: TextStyle(color: navyTheme),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: navyTheme),
                                items: [
                                  '200 sqr meters',
                                  '500 sqr meters',
                                  '900 sqr meters',
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
                                      _standSize = val;
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
                                "Storeys",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                          Expanded(
                              flex: 3,
                              child: DropdownButton(
                                hint: _standSize == null
                                    ? Text('select one')
                                    : Text(
                                        _standSize,
                                        style: TextStyle(color: navyTheme),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: navyTheme),
                                items: [
                                  'Single',
                                  'Double',
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
                                      _standSize = val;
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
                          getAllListings(3);
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
                          getAllListings(3);
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

  Widget _flatHouse() {
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
                  hint: _standSize == null
                      ? Text('select one')
                      : Text(
                          _standSize,
                          style: TextStyle(color: navyTheme),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: navyTheme),
                  items: [
                    'CBD',
                    'form input',
                    'Low Density',
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
                        _standSize = val;
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
                    "Surbub",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
              Expanded(
                  flex: 3,
                  child: DropdownButton(
                    hint: _standSize == null
                        ? Text('select one')
                        : Text(
                            _standSize,
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
                          _standSize = val;
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
                                "Stand size",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                          Expanded(
                              flex: 3,
                              child: DropdownButton(
                                hint: _standSize == null
                                    ? Text('select one')
                                    : Text(
                                        _standSize,
                                        style: TextStyle(color: navyTheme),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: navyTheme),
                                items: [
                                  '200 sqr meters',
                                  '500 sqr meters',
                                  '900 sqr meters',
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
                                      _standSize = val;
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
                                "Storeys",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                          Expanded(
                              flex: 3,
                              child: DropdownButton(
                                hint: _standSize == null
                                    ? Text('select one')
                                    : Text(
                                        _standSize,
                                        style: TextStyle(color: navyTheme),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: navyTheme),
                                items: [
                                  'Single',
                                  'Double',
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
                                      _standSize = val;
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
                          getAllListings(5);
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
                          getAllListings(5);
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

  Widget _commercialBuilding() {
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
                    hint: _standSize == null
                        ? Text('select one')
                        : Text(
                            _standSize,
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
                          _standSize = val;
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
                    "Surbub",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
              Expanded(
                  flex: 3,
                  child: DropdownButton(
                    hint: _standSize == null
                        ? Text('select one')
                        : Text(
                            _standSize,
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
                          _standSize = val;
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
                    " No. of Apartments",
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
                                "Stand size",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                          Expanded(
                              flex: 3,
                              child: DropdownButton(
                                hint: _standSize == null
                                    ? Text('select one')
                                    : Text(
                                        _standSize,
                                        style: TextStyle(color: navyTheme),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: navyTheme),
                                items: [
                                  '200 sqr meters',
                                  '500 sqr meters',
                                  '900 sqr meters',
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
                                      _standSize = val;
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
                                "Storeys",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                          Expanded(
                              flex: 3,
                              child: DropdownButton(
                                hint: _standSize == null
                                    ? Text('select one')
                                    : Text(
                                        _standSize,
                                        style: TextStyle(color: navyTheme),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: navyTheme),
                                items: [
                                  'Single',
                                  'Double',
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
                                      _standSize = val;
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
                          getAllListings(5);
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
                        child: Text(
                          "Search",
                          style: whiteSmallerTextStyle(),
                        ),
                        onPressed: () {
                          getAllListings(5);
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

    if (selectedProperty == "Residential House") {
      _widgetTobeDisplayed = _residentialHouse();
    } else if (selectedProperty == "Commercial Building") {
      _widgetTobeDisplayed = _commercialBuilding();
    } else if (selectedProperty == "Flat/Apartment") {
      _widgetTobeDisplayed = _flatHouse();
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
                const EdgeInsets.only(top: 50.0, bottom: 120.0, right: 280.0),
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
              child: Text("Residential House", style: simpleTextStyle()),
              onPressed: () {
                setState(() {
                  isResidentialHouseSelected = true;
                  selectedProperty = "Residential House";
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
              child: Text("Flat/Apartment", style: simpleTextStyle()),
              onPressed: () {
                setState(() {
                  isFlatSelected = true;
                  selectedProperty = "Flat/Apartment";
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
              child: Text("Commercial Building", style: simpleTextStyle()),
              onPressed: () {
                setState(() {
                  isCormmecialBuildingSelected = true;
                  selectedProperty = "Commercial Building";
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
                  maxHeight: MediaQuery.of(context).size.height / 2.1),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            width: MediaQuery.of(context).size.width - 100.0,
            height: MediaQuery.of(context).size.height / 1.55,
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
                          isResidentialHouseSelected = false;
                          isFlatSelected = false;
                          isCormmecialBuildingSelected = false;
                          allListings = [];
                        });
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: navyTheme,
                      ),
                      label: Text(
                        "",
                      ),
                    ),
                    (isResidentialHouseSelected == true ||
                            isCormmecialBuildingSelected == true ||
                            isFlatSelected == true)
                        ? new Text(
                            propertyName,
                            textAlign: TextAlign.center,
                            style: simpleTextStyle(),
                          )
                        : Center(
                            child: new Text(
                              propertyName,
                              style: simpleTextStyle(),
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

  Position currentLocation;

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
              ), //map widget

        (isResidentialHouseSelected == false &&
                isFlatSelected == false &&
                isCormmecialBuildingSelected == false)
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
