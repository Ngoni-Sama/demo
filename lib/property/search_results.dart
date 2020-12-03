import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:solo_property_app/property/property_info.dart';
import 'package:solo_property_app/utils/solo_theme.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class SearchResults extends StatefulWidget {
  SearchResults({this.allListings});
  final allListings;
  static const routeName = "/search-results";
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  Position currentLocation;

  var geoPoint;

  Future getLive() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation)
        .then((Position position) {
      //logic code goes here
      // addLocation(position);
      setState(() {
        currentLocation = position;
      });
      print(currentLocation);
    }).catchError((dynamic e) {
      print(e);
    });
  }

  @override
  void initState() {
    getLive();
    super.initState();
  }

  Widget _buildMap() {
    return Stack(
      children: [
        FlutterMap(
          options: new MapOptions(
            center:
                new LatLng(currentLocation.latitude, currentLocation.longitude),
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
                  height: 120.0,
                  point: LatLng(
                      currentLocation.latitude,
                      currentLocation
                          .longitude), //LatLng(_currentPosition.latitude, _currentPosition.longitude),
                  builder: (context) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(
                      //   width: 60,
                      //   height: 40,
                      //   color: navyTheme,
                      //   child: Text(
                      //     "Me",
                      //     textAlign: TextAlign.center,
                      //     style: whiteSmallerTextStyle(),
                      //   ),
                      // ),
                      Icon(
                        Icons.location_on,
                        size: 45.0,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                for (var i = 0; i < widget.allListings.length; i++)
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(
                        widget.allListings[i]['sellGeolocation']['geopoint']
                            .latitude,
                        widget.allListings[i]['sellGeolocation']['geopoint']
                            .longitude), //LatLng(_currentPosition.latitude, _currentPosition.longitude),
                    builder: (context) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => PropertyDetails()));
                        print(widget.allListings[i]['sellGeolocation']);
                      },
                      child: Container(
                        width: 50,
                        child: Column(
                          children: [
                            Text(
                              " ${widget.allListings.length} listings",
                              style: simpleTextStyle(),
                            ),
                            Icon(
                              Icons.location_on,
                              size: 45.0,
                              color: navyTheme,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        Positioned(
          top: 60.0,
          left: 20.0,
          child: FloatingActionButton(
            splashColor: Colors.white,
            backgroundColor: navyTheme,
            onPressed: () {
              Navigator.pop(context);
              print(widget.allListings);
            },
            child: Icon(
              Icons.arrow_back,
            ),
            mini: true,
          ),
        ),
        // currentLocation == null
        //     ? Positioned(
        //         top: 5.0,
        //         child: Container(
        //           color: navyTheme.withOpacity(0.3),
        //           width: MediaQuery.of(context).size.width,
        //           height: MediaQuery.of(context).size.height,
        //           child: Center(
        //               child: CircularProgressIndicator(
        //                   strokeWidth: 2.0, backgroundColor: navyTheme)),
        //         ),
        //       )
        //     : '',
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMap();
  }
}
