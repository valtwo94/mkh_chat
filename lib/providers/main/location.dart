import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationProvider with ChangeNotifier {
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  MapController mapController = MapController();
  bool serviceEnabled = false;
  late LocationPermission permission;
  LatLng? currentLocation;
  String error = '';

  LocationProvider() {
    handlePermission();
    _checkLocationServices();
    _getCurrentPosition();
  }

  Future<void> _checkLocationServices() async {
    serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      error = 'Location services are disabled.';
      notifyListeners();
    }
  }

  Future<void> handlePermission() async {
    try {
      permission = await geolocatorPlatform.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await geolocatorPlatform.requestPermission();
        if (permission == LocationPermission.denied) {
          error = 'Location permissions are denied.';
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        error = 'Location permissions are permanently denied, we cannot request permissions.';
        notifyListeners();
        return;
      }

      // When permissions are granted, get the current location
      await _getCurrentPosition();
    } catch (e) {
      error = 'An error occurred while requesting permissions: $e';
      notifyListeners();
    }
  }

  Future<void> _getCurrentPosition() async {
    try {
      Position position = await geolocatorPlatform.getCurrentPosition();
      currentLocation = LatLng(position.latitude, position.longitude);
      mapController.move(currentLocation!, 10);
      notifyListeners();
    } catch (e) {
      error = 'An error occurred while fetching location: $e';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}