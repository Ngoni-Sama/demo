import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solo_property_app/property/my_listings.dart';
import 'package:solo_property_app/property/posting_options.dart';
import '../utils/solo_theme.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var selectedCard = "WEIGHT";
  var selectedButton = "posts";
  var email;
  var name;
  var accountType;
  var numberOfPosts;
  List posts;

  saveRegDetailsLocally() async {
    var localStorage = await SharedPreferences.getInstance();
    setState(() {
      email = localStorage.get('email');
    });
    print('USER PROFILE RUNING');
    getUserData(email);
  }

  var dbRef = Firestore.instance;
  List myListing = [];

  void getUserListings(email) async {
    if (email != null) {
      await dbRef
          .collection("listings")
          .where('sellerId', isEqualTo: email)
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        setState(() {
          numberOfPosts = snapshot.documents.length;
          posts = snapshot.documents;
        });

        posts.forEach((f) => {
              myListing.add(
                f.data,
              ),
            });
        print(myListing);
      });
    }
  }

  void getUserData(email) async {
    if (email != null) {
      print('EMAIL NOT NULL');
      getUserListings(email);
      await dbRef
          .collection("users")
          .where('userEmail', isEqualTo: email)
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) => {
              setState(() {
                name = f.data["name"];
                accountType = f.data["account_type"];
              }),
              print("Name is :" + name)
            });
      });
    }
  }

  Widget listingDetailCard(myListing) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.5, left: 5.0, right: 5.0),
      child: Card(
        color: Colors.blueGrey[50],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    color: navyTheme,
                  ),
                  child: Image.network(
                    myListing['sellImages'][0],
                    fit: BoxFit.cover,
                    scale: 2.0,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    (myListing['sellType'] == 3 ||
                            myListing['sellType'] == 1 ||
                            myListing['sellType'] == 2)
                        ? Center(
                            child: Text(
                              "Vehicle for sale",
                              style: simpleTextStyle(),
                            ),
                          )
                        : (myListing['sellType'] == 4 ||
                                myListing['sellType'] == 5 ||
                                myListing['sellType'] == 6)
                            ? Center(
                                child: Text(
                                  " House for sale",
                                  style: simpleTextStyle(),
                                ),
                              )
                            : (myListing['sellType'] == 7 ||
                                    myListing['sellType'] == 8 ||
                                    myListing['sellType'] == 9)
                                ? Center(
                                    child: Text(
                                      "Property rental",
                                      style: simpleTextStyle(),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      "Land for sale",
                                      style: simpleTextStyle(),
                                    ),
                                  ),
                    Center(
                      child: Text(
                        "USD" + " " + myListing["sellPrice"],
                        style: smallTextStyle(),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: OutlineButton(
                    child: Text("Boost", style: smallTextStyle()),
                    onPressed: () {
                      setState(() {});
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    saveRegDetailsLocally();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => PostingOptions()),
            );
          },
          backgroundColor: navyTheme,
          child: Icon(Icons.add),
        ),
        body: ListView(
          children: [
            Container(
              decoration: new BoxDecoration(
                color: navyTheme.withOpacity(0.5),
                image: new DecorationImage(
                  image: new AssetImage('assets/images/pattern.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: accountType == null
                  ? Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                        ),
                        Positioned(
                          top: 150.0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                              color: Colors.white,
                            ),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        Positioned(
                            top: 80.0,
                            left: (MediaQuery.of(context).size.width / 2),
                            child: accountType == null
                                ? SizedBox()
                                : Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: new AssetImage(
                                                'assets/images/realestate.jpg'),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 7.0,
                                              color: Colors.black45)
                                        ]),
                                    height: 100.0,
                                    width: 100.0,
                                  )),
                        Positioned(
                            top: 250.0,
                            left: MediaQuery.of(context).size.width / 2.2,
                            child: Center(child: CircularProgressIndicator())),
                        SizedBox(width: 10.0),
                      ],
                    )
                  : Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                        ),
                        Positioned(
                          top: 150.0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45.0),
                                topRight: Radius.circular(45.0),
                              ),
                              color: Colors.white,
                            ),
                            height: MediaQuery.of(context).size.height * 2,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        Positioned(
                            top: 80.0,
                            left: (MediaQuery.of(context).size.width / 2) - 60,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: new AssetImage(
                                          'assets/images/realestate.jpg'),
                                      fit: BoxFit.cover),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 7.0, color: Colors.black45)
                                  ]),
                              height: 100.0,
                              width: 100.0,
                            )),
                        Positioned(
                          top: 190.0,
                          left: 20,
                          right: 14.0,
                          child: Container(
                              child: Column(
                            children: <Widget>[
                              Text("$name", style: biggerTextStyle()),
                              SizedBox(height: 10),
                              Text("$accountType",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                      color: navyTheme.withOpacity(0.65))),
                              SizedBox(height: 10),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedButton = 'posts';
                                        });
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Text("$numberOfPosts",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22.0,
                                                  color: Colors.grey)),
                                          Text(
                                            "Posts",
                                            style: simpleTextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedButton = 'reviews';
                                        });
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Text("7",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22.0,
                                                  color: Colors.grey)),
                                          Text(
                                            "Reviews",
                                            style: simpleTextStyle(),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ),
                        Positioned(
                          top: 315.0,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                      width: 380,
                                      color: Colors.grey.withOpacity(0.3),
                                      height: 1.0),
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 310.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => MyListings(
                                            listings: myListing,
                                            myposts: myListing.length)),
                                  );
                                },
                                child: Text("see more",
                                    style: underlineSmallTextStyle()),
                              ),
                              for (var i = 0; i < 3; i++)
                                Container(
                                  // padding: EdgeInsets.only(right: 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: listingDetailCard(myListing[i]),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                      ],
                    ),
            ),
          ],
        ));
  }
}
