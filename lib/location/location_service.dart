import 'package:evently/location/location_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  static Future<LatLng?> pickLocation(BuildContext context) async {
    LatLng? pickedLocation = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationPicker()));
    return pickedLocation;
  }

  static Future<String> getLocationDetails(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return '${placemarks[0].thoroughfare},${placemarks[0].locality},${placemarks[0].country}';
  }
}
