import 'package:flutter/material.dart';
import 'package:solo_property_app/property/widgets/vehicle_components/product_image.dart';

class VehicleGridContent extends StatelessWidget {
  VehicleGridContent({this.pictures, this.make, this.model, this.price});

  final String pictures;
  final String model;
  final String make;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(color: Colors.white),
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 3, child: Center(child: ProductImage(pictures))),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                make + ' ' + model,
                style: TextStyle(
                  fontFamily: 'CircularStd',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                '\$' + price,
                style: TextStyle(
                  fontFamily: 'CircularStd',
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.indigo,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
