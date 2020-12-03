import 'package:flutter/material.dart';

import '../rounded_btn.dart';

class VehicleCardContent extends StatelessWidget {
  VehicleCardContent(
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
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffFFFFFF),
            border: Border.all(color: Color(0xff083663)),
            borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Make: ' + make,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Model: ' + model,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Mileage: ' + mileage,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Price: ' + '\$' + price,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                RoundedButton(
                  btnText: 'View Details',
                  onPressed: onPressed,
                )
              ],
            ),
            Image.network(
              pictures,
              fit: BoxFit.cover,
              width: 130.0,
              height: 130.0,
            ),
          ],
        ),
      ),
    );
  }
}
