import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorController extends ChangeNotifier {
  var longitude;
  var latitude;

  double calculateDistance(
      double startLat, double startLon, double endLat, double endLon) {
    if (startLat != null && startLon != null && endLat == 0 && endLon == 0) {
      return 0;
    } else {
      final distance =
          Geolocator.distanceBetween(startLat, startLon, endLat, endLon);
      final distanceInKilometers = distance / 1000;
      final roundedDistance =
          double.parse(distanceInKilometers.toStringAsFixed(1));

      return roundedDistance;
    }
  }

  //This method checks and requests location permissions, ensures that the device's location services are enabled
  // and retrieves the current device location
  Future<bool> checkLocationPermission() async {
    final status = await Geolocator.checkPermission();

    if (status == LocationPermission.denied) {
      final result = await Geolocator.requestPermission();
      if (result == LocationPermission.denied) {
        return false;
      }
    }

    if (await Geolocator.isLocationServiceEnabled()) {
    } else {
      Geolocator.openLocationSettings();
    }

    final location = await getCurrentLocation();
    if (location == null) {
      return false;
    } else {
      longitude = location.longitude;
      latitude = location.latitude;
      notifyListeners();
    }

    return true;
  }

  Future<Position?> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      print("$e");
      return null;
    }
  }
}
