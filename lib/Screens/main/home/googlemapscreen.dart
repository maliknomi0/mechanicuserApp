import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:repair/_Configs/assets.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  Completer<GoogleMapController> _googleMapController = Completer();
  final _controller = TextEditingController();
  CameraPosition? _cameraPosition;
  bool _showMap = false;
  Location? _location;
  LocationData? _currentLocation;

  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _init();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = (Random(12222322).toString());
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    const String PLACES_API_KEY = "AlzaSypOj9d62d2URqo36NlbgawbOmh8zRinJ6O";

    try {
      String baseURL =
          'https://maps.gomaps.pro/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$PLACES_API_KEY&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      if (kDebugMode) {
        print('mydata');
        print(data);
      }
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print(e);
    }
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

  moveToPosition(LatLng latlng) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latlng, zoom: 14.0)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search ',
                hintText: 'Search here...',
                prefixIcon: Icon(Icons.search),
                fillColor: Colors.transparent,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
              ),
              onFieldSubmitted: (value) {
                print("Search for: $value");
              },
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _placeList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {},
                child: ListTile(
                  title: Text(_placeList[index]["description"]),
                ),
              );
            },
          ),
          Expanded(
            child: _buildmap(),
          ),
        ],
      ),
    ));
  }

  Widget _buildmap() {
    return _getMap();
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
