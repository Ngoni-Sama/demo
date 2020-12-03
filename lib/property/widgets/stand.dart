import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:solo_property_app/property/property_listing.dart';
import 'package:solo_property_app/property/search_results.dart';
import 'package:solo_property_app/property/widgets/widgets.dart';
import 'package:solo_property_app/utils/solo_theme.dart';

class Stand extends StatefulWidget {
  @override
  _StandState createState() => _StandState();
}

class _StandState extends State<Stand> {
  bool isExpanded = false;

  bool isResidentialStandSelected = false;
  bool isCommercialStandSelected = false;
  bool isPLotSelected = false;

  String selectedProperty;
  String _standSize;
  String _standLocation;
  String _budget;

  List posts;

  var dbRef = Firestore.instance;
  List allListings = [];

  Widget _buildStand() {
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
                    hint: _standLocation == null
                        ? Text('select one')
                        : Text(
                            _standLocation,
                            style: TextStyle(color: navyTheme),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: navyTheme),
                    items: [
                      'Low density',
                      'High density',
                      'Medium density',
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
                          _standLocation = val;
                        },
                      );
                    },
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 15.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    "Stand Size",
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
                      '300 sqr meters',
                      '500 sqr meters',
                      '1000 sqr meters',
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
                  hint: _budget == null
                      ? Text('choose budget')
                      : Text(
                          _budget,
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
                        _budget = val;
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
                height: 230,
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
                                "Water",
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
                                "Slab",
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
                                "Corner Stand",
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
                                      _standSize = val;
                                    },
                                  );
                                },
                              )),
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
                          getAllListings(11);
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
                          getAllListings(11);
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

  Widget _buildBuyStandWidget() {
    return _buildStand();
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
                const EdgeInsets.only(top: 50.0, bottom: 150.0, right: 280.0),
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
              child: Text("Residential Stand"),
              onPressed: () {
                if (isResidentialStandSelected == false) {
                  setState(() {
                    isResidentialStandSelected = true;
                    selectedProperty = "Residential Stand";
                  });
                } else {
                  setState(() {
                    isResidentialStandSelected = false;
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
              child: Text("Commercial Stand"),
              onPressed: () {
                if (isCommercialStandSelected == false) {
                  setState(() {
                    isCommercialStandSelected = true;
                    selectedProperty = "Commercial Stand";
                  });
                } else {
                  setState(() {
                    isCommercialStandSelected = false;
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
            height: 8.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.6,
            height: 50.0,
            child: RaisedButton(
              child: Text("Plot"),
              onPressed: () {
                if (isPLotSelected == false) {
                  setState(() {
                    isPLotSelected = true;
                    selectedProperty = "Plot";
                  });
                } else {
                  setState(() {
                    isPLotSelected = false;
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
                  maxHeight: MediaQuery.of(context).size.height / 2.65),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            width: MediaQuery.of(context).size.width - 100.0,
            height: MediaQuery.of(context).size.height / 1.40,
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
                          isResidentialStandSelected = false;
                          isCommercialStandSelected = false;
                          isPLotSelected = false;
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: new Text(
                        propertyName,
                        style: TextStyle(
                            color: navyTheme,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.0,
                ),
                _buildBuyStandWidget()
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

  void getAllListings(sellType) async {
    print("FETCHING $sellType ");
    await dbRef
        .collection("listings")
        .where('sellType', isEqualTo: sellType)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      setState(() {
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

        (isResidentialStandSelected == false &&
                isPLotSelected == false &&
                isCommercialStandSelected == false)
            ? Positioned(top: 10.0, child: _buildPropertyChoice())
            : Positioned(
                top: 10.0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.withOpacity(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildFilterWidget(selectedProperty)
                      // (selectedProperty.length <= 3)
                      //     ? _buildFilterWidget(selectedProperty)
                      //     : SizedBox(),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
