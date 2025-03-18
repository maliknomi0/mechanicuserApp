import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:repair/themes/theme_constants.dart';

class pumpmapScreen extends StatefulWidget {
  const pumpmapScreen({super.key});

  @override
  _pumpmapScreenState createState() => _pumpmapScreenState();
}

class _pumpmapScreenState extends State<pumpmapScreen> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  LatLng? _selectedGasStation;
  String? _selectedGasStationName;
  bool _isLoading = false;

  // API key for Google Places API and Routes API
  final String _apiKey = 'AIzaSyDpaGUwa5HWOZBbxuz4zR8u8oB2FtWxSiA';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Get current user location
  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled')),
      );
      return;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Location permissions are permanently denied')),
      );
      return;
    }

    // Get current position
    final position = await Geolocator.getCurrentPosition();

    setState(() {
      _currentPosition = position;
      _addCurrentLocationMarker();
      _searchNearbyGasStations();
    });

    // Move camera to current location
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.0,
        ),
      ),
    );
  }

  // Add marker for current location
  void _addCurrentLocationMarker() {
    if (_currentPosition != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          infoWindow: const InfoWindow(title: 'My Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }
  }

  // Search for nearby gas stations
  void _searchNearbyGasStations() async {
    if (_currentPosition == null) return;

    setState(() {
      _isLoading = true;
    });

    final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'location=${_currentPosition!.latitude},${_currentPosition!.longitude}'
        '&radius=5000'
        '&type=gas_station'
        '&key=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          // Clear previous gas station markers
          _markers.removeWhere(
              (marker) => marker.markerId.value != 'currentLocation');

          // Add markers for each gas station
          for (var i = 0; i < data['results'].length; i++) {
            final place = data['results'][i];
            final location = place['geometry']['location'];
            final name = place['name'];

            final markerId = 'gasStation_$i';

            final marker = Marker(
              markerId: MarkerId(markerId),
              position: LatLng(location['lat'], location['lng']),
              infoWindow: InfoWindow(title: name),
              onTap: () {
                setState(() {
                  _selectedGasStation =
                      LatLng(location['lat'], location['lng']);
                  _selectedGasStationName = name;
                  _getRoutesApiDirections();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Getting directions to $name')),
                );
              },
            );

            setState(() {
              _markers.add(marker);
            });
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Error finding gas stations: ${data['status']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error searching for gas stations: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Get directions using the Routes API (newer than Directions API)
  void _getRoutesApiDirections() async {
    if (_currentPosition == null || _selectedGasStation == null) return;

    setState(() {
      _isLoading = true;
      _polylines.clear();
    });

    // Routes API uses a POST request with a JSON body
    final url = 'https://routes.googleapis.com/directions/v2:computeRoutes';

    // Build the request body for the Routes API
    final requestBody = {
      "origin": {
        "location": {
          "latLng": {
            "latitude": _currentPosition!.latitude,
            "longitude": _currentPosition!.longitude
          }
        }
      },
      "destination": {
        "location": {
          "latLng": {
            "latitude": _selectedGasStation!.latitude,
            "longitude": _selectedGasStation!.longitude
          }
        }
      },
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "computeAlternativeRoutes": false,
      "routeModifiers": {
        "avoidTolls": false,
        "avoidHighways": false,
        "avoidFerries": false
      },
      "languageCode": "en-US",
      "units": "IMPERIAL"
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'X-Goog-Api-Key': _apiKey,
          'X-Goog-FieldMask':
              'routes.polyline,routes.duration,routes.distanceMeters'
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data.containsKey('routes') && data['routes'].isNotEmpty) {
          final route = data['routes'][0];

          if (route.containsKey('polyline') &&
              route['polyline'].containsKey('encodedPolyline')) {
            final String encodedPolyline = route['polyline']['encodedPolyline'];
            final points = _decodePolyline(encodedPolyline);

            if (points.isNotEmpty) {
              setState(() {
                _polylines.add(
                  Polyline(
                    polylineId: const PolylineId('route'),
                    points: points,
                    color: primaryColor,
                    width: 5,
                  ),
                );
              });

              // Adjust camera to show the whole route
              LatLngBounds bounds = _getBounds(points);
              _mapController?.animateCamera(
                CameraUpdate.newLatLngBounds(bounds, 100),
              );

              // Calculate and show route information
              final double distanceKm = route['distanceMeters'] / 1000.0;
              final String duration = _formatDuration(route['duration']);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        'Distance: ${distanceKm.toStringAsFixed(1)} km, Duration: $duration')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Could not decode route points')),
              );
              _fallbackToDirectLine();
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No polyline in the response')),
            );
            _fallbackToDirectLine();
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No routes found')),
          );
          _fallbackToDirectLine();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Routes API error: ${response.statusCode}')),
        );
        _fallbackToDirectLine();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting directions: $e')),
      );
      _fallbackToDirectLine();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Format duration string from the Routes API
  String _formatDuration(String durationString) {
    // Routes API returns duration in format like "1234s" (seconds)
    if (durationString.endsWith('s')) {
      final seconds =
          int.tryParse(durationString.substring(0, durationString.length - 1));
      if (seconds != null) {
        final minutes = seconds ~/ 60;
        final remainingSeconds = seconds % 60;
        return '$minutes min $remainingSeconds sec';
      }
    }
    return durationString;
  }

  // Fallback to direct line if the Routes API fails
  void _fallbackToDirectLine() {
    if (_currentPosition == null || _selectedGasStation == null) return;

    final List<LatLng> polylineCoordinates = [
      LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      LatLng(_selectedGasStation!.latitude, _selectedGasStation!.longitude),
    ];

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('direct_route'),
          points: polylineCoordinates,
          color: redColor,
          width: 5,
        ),
      );
    });

    // Show message that we're using direct line as fallback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Using direct route as fallback')),
    );
  }

  // Create bounds for camera adjustment
  LatLngBounds _getBounds(List<LatLng> points) {
    double? minLat, maxLat, minLng, maxLng;

    for (final point in points) {
      if (minLat == null || point.latitude < minLat) {
        minLat = point.latitude;
      }
      if (maxLat == null || point.latitude > maxLat) {
        maxLat = point.latitude;
      }
      if (minLng == null || point.longitude < minLng) {
        minLng = point.longitude;
      }
      if (maxLng == null || point.longitude > maxLng) {
        maxLng = point.longitude;
      }
    }

    return LatLngBounds(
      southwest: LatLng(minLat!, minLng!),
      northeast: LatLng(maxLat!, maxLng!),
    );
  }

  // Decode polyline points
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      final p = LatLng((lat / 1E5), (lng / 1E5));
      poly.add(p);
    }
    return poly;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gas Station Finder'),
      ),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _currentPosition?.latitude ?? 0.0,
                      _currentPosition?.longitude ?? 0.0,
                    ),
                    zoom: 14.0,
                  ),
                  markers: _markers,
                  polylines: _polylines,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
                if (_isLoading)
                  const Center(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                if (_selectedGasStationName != null)
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.directions,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                'Directions to $_selectedGasStationName',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  _polylines.clear();
                                  _selectedGasStationName = null;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _searchNearbyGasStations,
        tooltip: 'Refresh Gas Stations',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
