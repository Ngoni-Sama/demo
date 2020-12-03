import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:solo_property_app/utils/solo_theme.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class Map extends StatefulWidget {
  Map({this.position});
  final position;
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterMap(
        options: new MapOptions(
          center:
              new LatLng(widget.position.latitude, widget.position.longitude),
          zoom: 14.0,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/ras-bere/ckg9keqyb3lzt19qotq9693o0/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoicmFzLWJlcmUiLCJhIjoiY2s4a3BjNDNoMDNlNzNrbjEyaXpzazNvaSJ9.8ft038fVmbJ_48K8VCC45w',
                'id': 'mapbox.streets', //
              }),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(
                    widget.position.latitude,
                    widget.position
                        .longitude), //LatLng(_currentPosition.latitude, _currentPosition.longitude),
                builder: (context) => new Container(
                  child: IconButton(
                      icon: Icon(Icons.location_on),
                      color: Colors.red,
                      iconSize: 40.0,
                      onPressed: () {}),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
