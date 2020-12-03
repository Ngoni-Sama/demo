import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:solo_property_app/property/widgets/details_components/details_screen.dart';
import 'package:solo_property_app/property/widgets/vehicle_components/vehicle_grid_content.dart';

class VehicleGridList extends StatefulWidget {
  @override
  _VehicleGridListState createState() => _VehicleGridListState();
}

class _VehicleGridListState extends State<VehicleGridList> {
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
            return GridView.builder(
                itemCount: snapshot.data.documents.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  {
                    return Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        InkWell(
                            child: VehicleGridContent(
                              make: ds['make'],
                              model: ds['model'],
                              price: ds['price'],
                              pictures: ds['pictures'],
                            ),
                            onTap: () {
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
                            }),
                      ],
                    );
                  }
                });
          }
        });
  }
}
