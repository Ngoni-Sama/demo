import 'package:flutter/material.dart';

import '../rounded_btn.dart';

class PropertyCardContent extends StatelessWidget {
  PropertyCardContent(
      {this.size, this.pictures, this.rooms, this.price, this.onPressed});

  final String size;
  final String pictures;
  final String rooms;
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
                    'Rooms: ' + rooms,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Size/m2: ' + size,
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
