import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solo_property_app/property/widgets/details_components/details_screen.dart';
import 'package:solo_property_app/property/widgets/vehicle_components/vehicle_card_content.dart';

class VehicleList extends StatefulWidget {
  @override
  _VehicleListState createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('vehicles').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Loading...',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff083663),
                ),
              ),
            );
          } else {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return Container(
                    child: VehicleCardContent(
                      make: ds['make'],
                      mileage: ds['mileage'],
                      model: ds['model'],
                      price: ds['price'],
                      pictures: ds['pictures'],
                      onPressed: () {
                        // this will navigate to details on pressed
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VehicleDetails(
                                make: ds['make'],
                                model: ds['model'],
                                negotiable: ds['negotiable'],
                                mileage: ds['mileage'],
                                picture: ds['pictures'],
                                price: ds['price'],
                                phoneNumber: ds['phone_number'],
                                whatsappNumber: ds['whatsapp_number'],
                              ),
                            ));
                      },
                    ),
                  );
                });
          }
        });
  }
}
