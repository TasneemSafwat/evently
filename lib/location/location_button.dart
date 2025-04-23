import 'package:evently/app_theme.dart';
import 'package:evently/location/location_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationButton extends StatefulWidget {
  final void Function(LatLng location, String address)? onLocationSelected;

  LocationButton({this.onLocationSelected});

  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  LatLng? selectedLocation;
  String? selectedAddress;

  Future<void> chooseLocation() async {
    LatLng? location = await LocationService.pickLocation(context);
    if (location != null) {
      String address = await LocationService.getLocationDetails(location);
      setState(() {
        selectedLocation = location;
        selectedAddress = address;
      });

      if (widget.onLocationSelected != null) {
        widget.onLocationSelected!(location, address);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // زر اختيار الموقع
        SizedBox(
          width: double.infinity,
          child: InkWell(
            onTap: chooseLocation,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xFFF1F4FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xFF5D5FEF),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF5D5FEF),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      selectedAddress == null
                          ? 'Choose Event Location'
                          : 'Change Location',
                      style: TextStyle(
                        color: Color(0xFF5D5FEF),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Color(0xFF5D5FEF),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: 12),

        // عرض العنوان بعد الاختيار
        if (selectedAddress != null)
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.primary,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.place, color: AppTheme.primary),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    selectedAddress!,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
