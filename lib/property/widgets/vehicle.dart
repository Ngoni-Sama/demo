import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:solo_property_app/property/property_listing.dart';
import 'package:solo_property_app/property/search_results.dart';
import 'package:solo_property_app/property/widgets/widgets.dart';
import 'package:solo_property_app/utils/solo_theme.dart';

class Vehicle extends StatefulWidget {
  @override
  _VehicleState createState() => _VehicleState();
}

class _VehicleState extends State<Vehicle> {
  bool isExpanded = false;
  bool isCarSelected = false;
  bool isBusSelected = false;
  bool isTruckSelected = false;

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
              child: Text("Car", style: simpleTextStyle()),
              onPressed: () {
                if (isCarSelected == false) {
                  setState(() {
                    isCarSelected = true;
                    selectedProperty = "Car";
                  });
                } else {
                  setState(() {
                    isCarSelected = false;
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
              child: Text(
                "Bus",
                style: simpleTextStyle(),
              ),
              onPressed: () {
                if (isBusSelected == false) {
                  setState(() {
                    isBusSelected = true;
                    selectedProperty = "Bus";
                  });
                } else {
                  setState(() {
                    isBusSelected = false;
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
              child: Text(
                "Truck",
                style: simpleTextStyle(),
              ),
              onPressed: () {
                if (isTruckSelected == false) {
                  setState(() {
                    isTruckSelected = true;
                    selectedProperty = "Truck";
                  });
                } else {
                  setState(() {
                    isTruckSelected = false;
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
                  maxHeight: MediaQuery.of(context).size.height / 2.1),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            width: MediaQuery.of(context).size.width - 100.0,
            height: MediaQuery.of(context).size.height / 1.30,
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
                          isCarSelected = false;
                          isBusSelected = false;
                          isTruckSelected = false;
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
                        propertyName + " for sale",
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
                            items: [
                              'Toyota',
                              'Nissan',
                              'Mazda',
                              'Datsun',
                              'Pegueot'
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
                                  _carMake = val;
                                },
                              );
                            },
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                (selectedProperty == "Bus")
                    ? Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  "No. of seats",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                )),
                            Expanded(
                              flex: 3,
                              child: DropdownButton(
                                hint: _busSeats == null
                                    ? Text('select one')
                                    : Text(
                                        _busSeats,
                                        style: TextStyle(color: navyTheme),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: navyTheme),
                                items: [
                                  '15 - 20',
                                  '20 - 30',
                                  '30 - 60',
                                  '60 - 75',
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
                                      _busSeats = val;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 8.0,
                      ),
                (selectedProperty == "Bus")
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  "Mileage",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                )),
                            Expanded(
                                flex: 3,
                                child: DropdownButton(
                                  hint: _carMileage == null
                                      ? Text('select one')
                                      : Text(
                                          _carMileage,
                                          style: TextStyle(color: navyTheme),
                                        ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  style: TextStyle(color: navyTheme),
                                  items: [
                                    '0 - 1000',
                                    '1000 - 5000',
                                    '5000 - 10000',
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
                                        _carMileage = val;
                                      },
                                    );
                                  },
                                )),
                          ],
                        ),
                      ),
                SizedBox(
                  height: 6.0,
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
                  height: 6.0,
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
                        height: (selectedProperty == "Bus") ? 210 : 170,
                        child: Column(
                          children: [
                            (selectedProperty == "Bus")
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 15.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              "Mileage",
                                              textAlign: TextAlign.center,
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                            )),
                                        Expanded(
                                            flex: 3,
                                            child: DropdownButton(
                                              hint: _carMileage == null
                                                  ? Text('select one')
                                                  : Text(
                                                      _carMileage,
                                                      style: TextStyle(
                                                          color: navyTheme),
                                                    ),
                                              isExpanded: true,
                                              iconSize: 30.0,
                                              style:
                                                  TextStyle(color: navyTheme),
                                              items: [
                                                '0 - 1000',
                                                '1000 - 5000',
                                                '5000 - 10000',
                                              ].map(
                                                (val) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: val,
                                                    child: Text(val),
                                                  );
                                                },
                                              ).toList(),
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    _carMileage = val;
                                                  },
                                                );
                                              },
                                            )),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 15.0),
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
                                              style:
                                                  TextStyle(color: navyTheme),
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
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 15.0),
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
                                              style:
                                                  TextStyle(color: navyTheme),
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
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 15.0),
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
                                              style:
                                                  TextStyle(color: navyTheme),
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
                                child: Text("Search",
                                    style: whiteSmallerTextStyle()),
                                onPressed: () {
                                  getAllListings(1);
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => SearchResults(
                                              allListings: allListings,
                                            )),
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
                              onPressed: () =>
                                  setState(() => isExpanded = true),
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
                                child: Text("Search",
                                    style: whiteSmallerTextStyle()),
                                onPressed: () {
                                  getAllListings(1);
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => SearchResults()),
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
                              onPressed: () =>
                                  setState(() => isExpanded = false),
                            ),
                          ),
                        ],
                      )
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
    print("reset");
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
              ), //get

        (isCarSelected == false &&
                isTruckSelected == false &&
                isBusSelected == false)
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
