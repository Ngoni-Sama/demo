import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solo_property_app/property/all_chats.dart';
import 'package:solo_property_app/property/login.dart';
import 'package:solo_property_app/property/posting_options.dart';
import 'package:solo_property_app/utils/solo_theme.dart';
import '../models/model_propertysell.dart';

import '../utils/method_utils.dart';
import '../utils/network_utils.dart';

import './explore.dart';
import './profile.dart';
import 'widgets/widgets.dart';

SharedPreferences localStorage;

class PropertyListing extends StatefulWidget {
  static const routeName = "/property-listing";
  @override
  _PropertyListingState createState() => _PropertyListingState();
}

class _PropertyListingState extends State<PropertyListing> {
  bool isFetching = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<PropertySellModel> propertySellList = [];

  int _currentIndex = 1;
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  bool isHouseSelected = false;
  bool isRentSelected = false;
  bool isVehicleSelected = false;
  bool isStandSelected = false;

  getUserInfo() async {
    localStorage = await SharedPreferences.getInstance();
    print("get user data IS RUNNING ");

    print(
        "Email Id: ${localStorage.get('email')}  Password: ${localStorage.get('password')}");
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
    getUserInfo();
    checkInternetConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        // appBar: AppBar(
        //   title: Text("Property Listing"),
        // ),
        // body: isFetchings
        //     ? Center(child: CircularProgressIndicator())
        //     : _buildPropertySearchWidget(),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
          },
          items: <BottomNavyBarItem>[
            // BottomNavyBarItem(
            //     title: Text('Home'),
            //     icon: Icon(Icons.home),
            //     activeColor: navyTheme),
            BottomNavyBarItem(
                title: Text('Sell', style: simpleTextStyle()),
                icon: Icon(Icons.add),
                activeColor: navyTheme),
            BottomNavyBarItem(
                title: Text('Search', style: simpleTextStyle()),
                icon: Icon(Icons.search),
                activeColor: navyTheme),
            BottomNavyBarItem(
                title: Text('Explore', style: simpleTextStyle()),
                icon: Icon(Icons.explore),
                activeColor: navyTheme),

            BottomNavyBarItem(
                title: Text('Connect', style: simpleTextStyle()),
                icon: Icon(Icons.chat_bubble),
                activeColor: navyTheme),
            BottomNavyBarItem(
                title: Text('You', style: simpleTextStyle()),
                icon: Icon(Icons.person_outline),
                activeColor: navyTheme),
          ],
        ),
        body: _buildPropertySearchWidget()
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.pushNamed(context, PropertySell.routeName);
        //   },
        //   heroTag: null,
        //   child: Icon(
        //     Icons.add,
        //     color: Colors.white,
        //   ),
        // ),
        );
  }

  bool searchBtnPressed = false;

  void searchPropertyCategory() {
    if (searchBtnPressed == false) {
      setState(() {
        searchBtnPressed = true;
      });
    } else {
      setState(() {
        searchBtnPressed = false;
      });
    }
  }

  Widget _buildMap() {
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
        Positioned(
          top: 10.0,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                searchBtnPressed == false ? SizedBox() : _buildSearchCategory(),
                SizedBox(
                  height: 40.0,
                ),
                Center(
                  child: FlatButton.icon(
                    color: Colors.white,
                    splashColor: themeColor,
                    onPressed: () {
                      searchPropertyCategory();
                    },
                    icon: Icon(
                      Icons.search,
                      color: navyTheme,
                      size: 25,
                    ),
                    label: Text(
                      "Search for Property",
                      style: simpleTextStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                searchBtnPressed == false ? SizedBox() : _buildHouseCategory()
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHouseCategory() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: RaisedButton(
            animationDuration: Duration(seconds: 1000),
            child: Text("House"),
            onPressed: () {
              if (isHouseSelected == false) {
                setState(() {
                  isHouseSelected = true;
                });
                _pageController.animateToPage(4,
                    duration: Duration(microseconds: 300),
                    curve: Curves.easeIn);

                // _pageController.jumpToPage(1);
              } else {
                setState(() {
                  isHouseSelected = false;
                });
              }
            },
            color: Colors.white,
            textColor: navyTheme,
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            splashColor: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchCategory() {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text("Stand"),
                onPressed: () {
                  if (isStandSelected == false) {
                    setState(() {
                      isStandSelected = true;
                    });
                    _pageController.animateToPage(3,
                        duration: Duration(microseconds: 300),
                        curve: Curves.fastOutSlowIn);

                    // _pageController.jumpToPage(1);
                  } else {
                    setState(() {
                      isStandSelected = false;
                    });
                  }
                },
                color: Colors.white,
                textColor: navyTheme,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                splashColor: Colors.grey,
              ),
            )),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text("Vehicle"),
                onPressed: () {
                  if (isVehicleSelected == false) {
                    setState(() {
                      isVehicleSelected = true;
                    });
                    _pageController.animateToPage(1,
                        duration: Duration(microseconds: 300),
                        curve: Curves.fastOutSlowIn);

                    // _pageController.jumpToPage(1);
                  } else {
                    setState(() {
                      isVehicleSelected = false;
                    });
                  }
                },
                color: Colors.white,
                textColor: navyTheme,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                splashColor: Colors.grey,
              ),
            )),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text("Rent"),
                onPressed: () {
                  if (isRentSelected == false) {
                    setState(() {
                      isRentSelected = true;
                    });
                    _pageController.animateToPage(2,
                        duration: Duration(microseconds: 300),
                        curve: Curves.fastOutSlowIn);
                  } else {
                    setState(() {
                      isRentSelected = false;
                    });
                  }
                },
                color: Colors.white,
                textColor: navyTheme,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                splashColor: Colors.grey,
              ),
            ))
      ],
    );
  }

  Widget _buildPropertySearchWidget() {
    Widget displayedWidget;

    if (_currentIndex == 0) {
      if (localStorage.get('email') == null &&
          localStorage.get('password') == null) {
        displayedWidget = SignIn(
          goToPage: PostingOptions(),
        );
      } else {
        displayedWidget = PostingOptions();
      }

      // PropertySell();
    }
    if (_currentIndex == 1) {
      displayedWidget = PageView(
        physics: new NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: <Widget>[_buildMap(), Vehicle(), Rent(), Stand(), House()],
      );
    } else if (_currentIndex == 2) {
      displayedWidget = ExplorePage();
    } else if (_currentIndex == 3) {
      displayedWidget = AllChats();
    } else if (_currentIndex == 4) {
      displayedWidget = UserProfile();
    } else if (_currentIndex <= 5) {
      setState(() {
        _currentIndex = 0;
      });
    }
    return displayedWidget;
  }

  checkInternetConnection() async {
    NetworkCheck networkCheck = NetworkCheck();
    networkCheck.checkInternet((isNetworkPresent) async {
      if (!isNetworkPresent) {
        final snackBar =
            SnackBar(content: Text("Please check your internet connection !!"));

        _scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      } else {
        final snackBar = SnackBar(content: Text("You are now Online!!"));
        _scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
    });
  }
}
