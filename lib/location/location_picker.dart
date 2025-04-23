import 'package:evently/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocationPicker extends StatefulWidget {
  static const String routeName = '/location';

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  LatLng? selectedLocation;

  void onTap(LatLng latlng) {
    setState(() {
      selectedLocation = latlng;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    LatLng initialPosition =
        locationProvider.userLocation ?? LatLng(31.0818406, 29.8935053);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pick a Location'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: selectedLocation == null
                ? null
                : () {
                    Navigator.pop(context, selectedLocation);
                  },
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialPosition,
          zoom: 15,
        ),
        onTap: onTap,
        markers: selectedLocation != null
            ? {
                Marker(
                  markerId: MarkerId('selected_location'),
                  position: selectedLocation!,
                ),
              }
            : {},
      ),
    );
  }
}
