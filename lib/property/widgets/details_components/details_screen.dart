import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../rounded_btn.dart';

class VehicleDetails extends StatelessWidget {
  VehicleDetails(
      {Key key,
      @required this.make,
      @required this.model,
      @required this.mileage,
      @required this.price,
      @required this.picture,
      @required this.negotiable,
      @required this.phoneNumber,
      @required this.whatsappNumber})
      : super(key: key);

  final String make;
  final String model;
  final String mileage;
  final String price;
  final bool negotiable;
  final String phoneNumber;
  final String picture;
  final String whatsappNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop(true);
            }),
        title: Text(
          'Details',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: 'Gilroy'),
        ),
        backgroundColor: Color(0xff083663),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          make,
                          style: TextStyle(
                            color: Color(0xff083663),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          model,
                          style: TextStyle(
                            color: Color(0xff083663),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Image.network(
                      picture,
                      fit: BoxFit.cover,
                      width: 300,
                      height: 150.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      color: Color(0xff083663),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'US' + '\$' + price,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Negotiable',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_sharp,
                        color: Color(0xff083663),
                      ),
                      Text(
                        '3rd Avenue, ',
                        style: TextStyle(
                          color: Color(0xff083663),
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Bulawayo',
                        style: TextStyle(
                          color: Color(0xff083663),
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person_pin,
                        color: Color(0xff083663),
                      ),
                      Text(
                        'John Doe',
                        style: TextStyle(
                          color: Color(0xff083663),
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Card(
                    child: ExpansionTile(
                      title: Text(
                        'Reviews',
                        style: TextStyle(
                          color: Color(0xff083663),
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Description',
                      style: TextStyle(
                        color: Color(0xff083663),
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Company car that is in good condition',
                      style: TextStyle(
                        color: Color(0xff083663),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Text(
                          'Make: ',
                          style: TextStyle(
                            color: Color(0xff083663),
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          make,
                          style: TextStyle(
                            color: Color(0xff083663),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Text(
                          'Model: ',
                          style: TextStyle(
                            color: Color(0xff083663),
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          model,
                          style: TextStyle(
                            color: Color(0xff083663),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Text(
                          'Year: ',
                          style: TextStyle(
                            color: Color(0xff083663),
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '2006',
                          style: TextStyle(
                            color: Color(0xff083663),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Text(
                          'Colour: ',
                          style: TextStyle(
                            color: Color(0xff083663),
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Silver',
                          style: TextStyle(
                            color: Color(0xff083663),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Text(
                          'Gearbox: ',
                          style: TextStyle(
                            color: Color(0xff083663),
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Automatic',
                          style: TextStyle(
                            color: Color(0xff083663),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Text(
                          'Mileage: ',
                          style: TextStyle(
                            color: Color(0xff083663),
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          mileage + ' km',
                          style: TextStyle(
                            color: Color(0xff083663),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RoundedButton(
                          btnText: 'Phone',
                          onPressed: () {
                            // Open dailer to call number
                            String phoneCall = 'tel:' + phoneNumber;
                            launch(phoneCall);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RoundedButton(
                          btnText: 'WhatsApp',
                          onPressed: () {
                            // Open whatsapp
                            String openWhatsApp =
                                'https://api.whatsapp.com/send?phone=$whatsappNumber';
                            launch(openWhatsApp);
                          },
                        ),
                      )
                    ],
                  ),
                ])),
      ),
    );
  }
}
