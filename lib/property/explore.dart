import 'package:flutter/material.dart';
import 'package:solo_property_app/property/widgets/mechanic_components/mechanic_card_content.dart';
import 'package:solo_property_app/property/widgets/property_components/property_card.dart';
import 'package:solo_property_app/property/widgets/vehicle_components/vehicle_card.dart';
import 'package:solo_property_app/property/widgets/vehicle_components/vehicle_grid.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Color(0xffFFFFFF),
          appBar: AppBar(
            backgroundColor: Color(0xffFFFFFF),
            bottom: TabBar(
              labelColor: Color(0xff083663),
              tabs: [
                Tab(
                  text: 'VEHICLES',
                ),
                Tab(
                  text: 'PROPERTIES',
                ),
                Tab(
                  text: 'MECHANIC',
                )
              ],
            ),
            title: Center(
              child: Text(
                'Explore Products',
                style: TextStyle(color: Color(0xff083663)),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              VehicleGridList(),
              PropertyList(),
              MechanicCardContent(),
            ],
          ),
        ),
      ),
    );
  }
}
