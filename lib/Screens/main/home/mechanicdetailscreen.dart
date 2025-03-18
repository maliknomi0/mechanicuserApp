import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:repair/Screens/main/home/chatscreen.dart';
import 'package:repair/_Configs/assets.dart';
import 'package:repair/themes/theme_constants.dart';

class MechanicDetails extends StatefulWidget {
  const MechanicDetails({super.key});

  @override
  State<MechanicDetails> createState() => _MechanicDetailsState();
}

class _MechanicDetailsState extends State<MechanicDetails> {
  final Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  bool _showMap = false;
  Location? _location;
  LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    _location = Location();
    _cameraPosition = CameraPosition(
      target: LatLng(0, 0),
      zoom: 14.0,
    );
    _initLocation();
  }

  _initLocation() {
    _location?.getLocation().then((location) {
      _currentLocation = location;
    });
    _location?.onLocationChanged.listen((newLocation) {
      _currentLocation = newLocation;
      moveToPosition(LatLng(
          _currentLocation?.latitude ?? 0, _currentLocation?.longitude ?? 0));
    });
  }

  // Future<LocationData?> _getCurrentLocation() async {
  //   var currentLocation = await _location?.getLocation();
  //   return currentLocation ?? null;
  // }

  // moveToCurrentLocation() async {
  //   LocationData? currentLocation = await _getCurrentLocation();
  //   moveToPosition(LatLng(
  //       currentLocation?.latitude ?? 0, currentLocation?.longitude ?? 0));
  // }

  moveToPosition(LatLng latlng) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latlng, zoom: 14.0)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Mechanic"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Expanded(
              child: Column(children: [
            Image.asset(AppIamges.mechanic),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Description",
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Second Text",
                      ),
                      SizedBox(height: 4),
                      Text(
                        "⬆ Blue Icon",
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "4 Reviews",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text("Maps"),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showMap = true;
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _showMap
                        ? _getMap() // Show Google Map if clicked
                        : Image.asset(
                            AppIamges.map, // Show static image initially
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text("Reviews"),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(AppIamges.mechanic),
                          child: Container(),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Hammad',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Great Experience!',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 320,
                    height: buttonhight,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text('click me'),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen()),
                      );
                    },
                    child: SizedBox(
                      width: 37,
                      child: Image.asset(AppIamges.chatIcon),
                    ),
                  )
                ],
              ),
            ),
          ])),
        ]),
      ),
    ));
  }

  Widget _getMap() {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _cameraPosition!,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            if (!_googleMapController.isCompleted) {
              _googleMapController.complete(controller);
            }
          },
        ),
        Positioned.fill(
            child: Align(alignment: Alignment.center, child: _getMarker())),
      ],
    );
  }

  Widget _getMarker() {
    return SizedBox(
      width: 37,
      child: Image.asset(AppIamges.mapmarker),
    );
  }
}
