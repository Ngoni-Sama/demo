import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solo_property_app/property/widgets/property_components/property_card_content.dart';
import 'package:solo_property_app/property/widgets/vehicle_components/vehicle_card_content.dart';

class PropertyList extends StatefulWidget {
  @override
  _PropertyListState createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('properties').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Loading...',
                style: TextStyle(
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
                    child: PropertyCardContent(
                      size: ds['size/m2'],
                      rooms: ds['rooms'],
                      price: ds['price'],
                      pictures: ds['pictures'],
                      onPressed: () {
                        // this will navigate to details on pressed
                      },
                    ),
                  );
                });
          }
        });
  }
}
