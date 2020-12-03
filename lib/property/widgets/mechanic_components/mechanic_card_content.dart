import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../rounded_btn.dart';

class MechanicCardContent extends StatelessWidget {
  /*MechanicCardContent(
      {this.mileage,
        this.pictures,
        this.make,
        this.model,
        this.price,
        this.onPressed});

  final String mileage;
  final String pictures;
  final String model;
  final String make;
  final String price;
  final Function onPressed;*/

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            height: 260,
            decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                border: Border.all(color: Color(0xff083663)),
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Busani Moyo',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Motor Mechanic',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              Text(
                                '3rd Avenue, Bulawayo',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Fee: ' + '\$20',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        RoundedButton(
                          btnText: 'HIRE',
                          onPressed: () {
                            // Open whatsapp
                            String openWhatsApp =
                                'https://api.whatsapp.com/send?phone=733803735';
                            launch(openWhatsApp);
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        'https://media.istockphoto.com/photos/mechanic-holding-tools-picture-id502423025?k=6&m=502423025&s=612x612&w=0&h=A0KcriQYfA8h15t6q8rkSoAclBtaHG0GFhBnVpDcnqA=',
                        fit: BoxFit.cover,
                        width: 130.0,
                        height: 130.0,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
