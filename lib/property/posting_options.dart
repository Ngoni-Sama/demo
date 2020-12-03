import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solo_property_app/property/post_property.dart';

import '../utils/solo_theme.dart';

//POSTING OPTIONS RENT,SELL,LAND ETC
class PostingOptions extends StatefulWidget {
  @override
  _PostingOptionsState createState() => _PostingOptionsState();
}

class _PostingOptionsState extends State<PostingOptions> {
  String postingOptionSelected = '';

  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  // Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  goToSellPropertyPage() {
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => PropertySell(
                sellCategory: postingOptionSelected,
                itemToPost: selectedRadio,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // leading: Text(""),
          backgroundColor: navyTheme,
          title: Text("Post Property", style: whiteBiggerTextStyle())),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
          color: navyTheme.withOpacity(0.2),
          image: new DecorationImage(
            image: new AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  animationDuration: Duration(seconds: 1000),
                  child: Text(
                    "Vehicle",
                    style: GoogleFonts.oswald(
                        fontSize: 14,
                        color: postingOptionSelected == "Vehicle"
                            ? Colors.white
                            : navyTheme,
                        letterSpacing: 1.1,
                        // decoration: TextDecoration.underline,

                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    setState(() {
                      postingOptionSelected = "Vehicle";
                    });
                  },
                  color: postingOptionSelected == "Vehicle"
                      ? navyTheme
                      : Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  splashColor: Colors.grey,
                ),
              ),
            ),
            postingOptionSelected == "Vehicle"
                ? Padding(
                    padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            width: MediaQuery.of(context).size.width,
                            child: OutlineButton(
                              child: Text("Post car for sale",
                                  style: smallTextStyle()),
                              onPressed: () {
                                setState(() {
                                  selectedRadio = 1;
                                });
                                goToSellPropertyPage();
                              },
                            )),
                        Container(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            width: MediaQuery.of(context).size.width,
                            child: OutlineButton(
                              child: Text("Post bus for sale",
                                  style: smallTextStyle()),
                              onPressed: () {
                                setState(() {
                                  selectedRadio = 2;
                                });
                                goToSellPropertyPage();
                              },
                            )),
                        Container(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          width: MediaQuery.of(context).size.width,
                          child: OutlineButton(
                            child: Text("Post truck for sale",
                                style: smallTextStyle()),
                            onPressed: () {
                              setState(() {
                                selectedRadio = 3;
                              });
                              goToSellPropertyPage();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.only(right: 40.0, left: 40.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  animationDuration: Duration(seconds: 1000),
                  child: Text(
                    "House",
                    style: GoogleFonts.oswald(
                        fontSize: 14,
                        color: postingOptionSelected == "House"
                            ? Colors.white
                            : navyTheme,
                        letterSpacing: 1.1,
                        // decoration: TextDecoration.underline,

                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    setState(() {
                      postingOptionSelected = "House";
                    });
                  },
                  color: postingOptionSelected == "House"
                      ? navyTheme
                      : Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  splashColor: Colors.grey,
                ),
              ),
            ),
            postingOptionSelected == "House"
                ? Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            width: MediaQuery.of(context).size.width,
                            child: OutlineButton(
                              child: Text("Post residential house for sale",
                                  style: smallTextStyle()),
                              onPressed: () {
                                setState(() {
                                  selectedRadio = 4;
                                });
                                goToSellPropertyPage();
                              },
                            )),
                        Container(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            width: MediaQuery.of(context).size.width,
                            child: OutlineButton(
                              child: Text("Post flat/apartment for sale",
                                  style: smallTextStyle()),
                              onPressed: () {
                                setState(() {
                                  selectedRadio = 5;
                                });
                                goToSellPropertyPage();
                              },
                            )),
                        Container(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            width: MediaQuery.of(context).size.width,
                            child: OutlineButton(
                              child: Text("Post commercial building for sale",
                                  style: smallTextStyle()),
                              onPressed: () {
                                setState(() {
                                  selectedRadio = 6;
                                });
                                goToSellPropertyPage();
                              },
                            )),
                      ],
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.only(right: 40.0, left: 40.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  animationDuration: Duration(seconds: 1000),
                  child: Text(
                    "Rent",
                    style: GoogleFonts.oswald(
                        fontSize: 14,
                        color: postingOptionSelected == "Rent"
                            ? Colors.white
                            : navyTheme,
                        letterSpacing: 1.1,
                        // decoration: TextDecoration.underline,

                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    setState(() {
                      postingOptionSelected = "Rent";
                    });
                  },
                  color: postingOptionSelected == "Rent"
                      ? navyTheme
                      : Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  splashColor: Colors.grey,
                ),
              ),
            ),
            postingOptionSelected == "Rent"
                ? Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            width: MediaQuery.of(context).size.width,
                            child: OutlineButton(
                              child: Text("Post house to rent",
                                  style: smallTextStyle()),
                              onPressed: () {
                                setState(() {
                                  selectedRadio = 7;
                                });
                                goToSellPropertyPage();
                              },
                            )),
                        Container(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          width: MediaQuery.of(context).size.width,
                          child: OutlineButton(
                            child: Text("Post Business Premise to rent",
                                style: smallTextStyle()),
                            onPressed: () {
                              setState(() {
                                selectedRadio = 8;
                              });
                              goToSellPropertyPage();
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          width: MediaQuery.of(context).size.width,
                          child: OutlineButton(
                            child: Text("Post Flat/Apartment to rent",
                                style: smallTextStyle()),
                            onPressed: () {
                              setState(() {
                                selectedRadio = 9;
                              });
                              goToSellPropertyPage();
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          width: MediaQuery.of(context).size.width,
                          child: OutlineButton(
                            child: Text("Post student accomodation to rent",
                                style: smallTextStyle()),
                            onPressed: () {
                              setState(() {
                                selectedRadio = 10;
                              });
                              goToSellPropertyPage();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.only(right: 40.0, left: 40.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  animationDuration: Duration(seconds: 1000),
                  child: Text(
                    "Stand/Land",
                    style: GoogleFonts.oswald(
                        fontSize: 14,
                        color: postingOptionSelected == "Stand"
                            ? Colors.white
                            : navyTheme,
                        letterSpacing: 1.1,
                        // decoration: TextDecoration.underline,

                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    setState(() {
                      postingOptionSelected = "Stand";
                    });
                  },
                  color: postingOptionSelected == "Stand"
                      ? navyTheme
                      : Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  splashColor: Colors.grey,
                ),
              ),
            ),
            postingOptionSelected == "Stand"
                ? Padding(
                    padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          width: MediaQuery.of(context).size.width,
                          child: OutlineButton(
                            child: Text("Post residential stand for sale",
                                style: smallTextStyle()),
                            onPressed: () {
                              setState(() {
                                selectedRadio = 11;
                              });
                              goToSellPropertyPage();
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          width: MediaQuery.of(context).size.width,
                          child: OutlineButton(
                            child: Text("Post commercial stand for sale",
                                style: smallTextStyle()),
                            onPressed: () {
                              setState(() {
                                selectedRadio = 12;
                              });
                              goToSellPropertyPage();
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          width: MediaQuery.of(context).size.width,
                          child: OutlineButton(
                            child: Text("Post plot/farm for sale",
                                style: smallTextStyle()),
                            onPressed: () {
                              setState(() {
                                selectedRadio = 13;
                              });
                              goToSellPropertyPage();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
