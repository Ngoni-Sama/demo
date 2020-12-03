import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solo_property_app/utils/solo_theme.dart';

class MyListings extends StatefulWidget {
  final List listings;
  final int myposts;

  MyListings({Key key, this.listings, this.myposts});
  @override
  _MyListingsState createState() => _MyListingsState();
}

class _MyListingsState extends State<MyListings> {
  var dbRef = Firestore.instance;
  var selectedBoostPayment = 1;

  // void saveRegDetailsLocally() async {
  //   var localStorage = await SharedPreferences.getInstance();
  //   setState(() {
  //     email = localStorage.get('email');
  //   });
  //   print('USER PROFILE RUNING');
  //   getUserListings(email);
  // }

  // void getUserListings(email) async {
  //   if (email != null) {
  //     await dbRef
  //         .collection("listings")
  //         .where('sellerId', isEqualTo: email)
  //         .getDocuments()
  //         .then((QuerySnapshot snapshot) {
  //       snapshot.documents.forEach((f) => {
  //             myListing.add(
  //               f.data,
  //             ),
  //           });
  //       print(myListing);
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   saveRegDetailsLocally();
  //   super.initState();
  // }

  void boostPost() {
    showDialog(
      context: context,
      child: new AlertDialog(
        // title: new Text("Property Posted", style: biggerTextStyle()),
        //content: new Text("Hello World"),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text("Boost Post", style: biggerTextStyle()),
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  new Text("5 Zwl", style: simpleTextStyle()),
                  Radio(
                    value: 1,
                    groupValue: selectedBoostPayment,
                    onChanged: (val) {
                      setState(() {
                        selectedBoostPayment = val;
                      });
                    },
                  ),
                  new Text("(post seen by 1000+ people)",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blueGrey[300],
                      )),
                ],
              ),
              Row(
                children: [
                  new Text("15 Zwl", style: simpleTextStyle()),
                  Radio(
                    value: 2,
                    groupValue: selectedBoostPayment,
                    onChanged: (val) {
                      setState(() {
                        selectedBoostPayment = val;
                      });
                    },
                  ),
                  new Text("(post seen by 5000+ people)",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blueGrey[300],
                      )),
                ],
              ),
              Row(
                children: [
                  new Text("25 Zwl", style: simpleTextStyle()),
                  Radio(
                    value: 3,
                    groupValue: selectedBoostPayment,
                    onChanged: (val) {
                      setState(() {
                        selectedBoostPayment = val;
                      });
                    },
                  ),
                  new Text("(post seen by 10000+ people)",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blueGrey[300],
                      )),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              new FlatButton(
                child: new Text('Cancel', style: simpleTextStyle()),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(
                  'Continue',
                  style: simpleTextStyle(),
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   CupertinoPageRoute(
                  //       builder: (context) => PostingOptions()),
                  // // );
                  // Navigator.push(
                  //   context,
                  //   CupertinoPageRoute(builder: (context) => PropertyListing()),
                  // );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget listingDetailCard(listings) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
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
                    listings['sellImages'][0],
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
                    (listings['sellType'] == 3 ||
                            listings['sellType'] == 1 ||
                            listings['sellType'] == 2)
                        ? Center(
                            child: Text(
                              "Vehicle for sale",
                              style: simpleTextStyle(),
                            ),
                          )
                        : (listings['sellType'] == 4 ||
                                listings['sellType'] == 5 ||
                                listings['sellType'] == 6)
                            ? Center(
                                child: Text(
                                  " House for saale",
                                  style: simpleTextStyle(),
                                ),
                              )
                            : (listings['sellType'] == 7 ||
                                    listings['sellType'] == 8 ||
                                    listings['sellType'] == 9)
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
                        listings['sellPrice'].toString(),
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
                      boostPost();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My listings"),
        backgroundColor: navyTheme,
      ),
      body: Container(
        decoration: new BoxDecoration(
          color: navyTheme.withOpacity(0.2),
          image: new DecorationImage(
            image: new AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            widget.listings.length == 0
                ? Column(
                    children: [Center(child: CircularProgressIndicator())],
                  )
                : Column(
                    children: [
                      for (var i = 0; i < widget.myposts; i++)
                        Container(
                          padding: EdgeInsets.only(right: 15),
                          width: MediaQuery.of(context).size.width,
                          child: listingDetailCard(widget.listings[i]),
                        ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
