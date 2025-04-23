import 'package:evently/app_theme.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/location_provider.dart';
import 'package:evently/tabs/map/map_item.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTab extends StatefulWidget {
  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  GoogleMapController? mapController;

  void _centerMap({required LatLng newLatLng}) {
    mapController?.animateCamera(
      CameraUpdate.newLatLng(newLatLng),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var eventListProvider = Provider.of<EventProvider>(context);
    var locationProvider = Provider.of<LocationProvider>(context);

    Set<Circle> eventCircles = eventListProvider.allEvents
        .where((event) => event.late != null && event.long != null)
        .map(
          (event) => Circle(
            circleId: CircleId(event.id),
            center: LatLng(
              double.parse(event.late!),
              double.parse(event.long!),
            ),
            radius: 100,
            fillColor: AppTheme.primary.withOpacity(0.3),
            strokeColor: AppTheme.primary,
            strokeWidth: 2,
          ),
        )
        .toSet();

    Set<Marker> eventMarkers = eventListProvider.allEvents
        .where((event) => event.late != null && event.long != null)
        .map(
          (event) => Marker(
            markerId: MarkerId(event.id),
            position: LatLng(
              double.parse(event.late!),
              double.parse(event.long!),
            ),
            infoWindow: InfoWindow(
              title: event.title,
              snippet: event.address ?? '',
              onTap: () {
                _centerMap(
                  newLatLng: LatLng(
                    double.parse(event.late!),
                    double.parse(event.long!),
                  ),
                );
              },
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
          ),
        )
        .toSet();

    return eventListProvider.filteredEvent.isEmpty
        ? SafeArea(
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
                Expanded(
                  child: Image.asset(
                    'assets/images/onboarding.png',
                  ),
                ),
              ],
            ),
          )
        : Stack(
            children: [
              GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: locationProvider.userLocation ??
                      LatLng(31.0872111, 29.9140115),
                  zoom: 17,
                ),
                circles: eventCircles,
                markers: eventMarkers,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
              ),
              Positioned(
                top: 50,
                right: 16,
                child: InkWell(
                  onTap: () {
                    _centerMap(
                      newLatLng: locationProvider.userLocation!,
                    );
                  },
                  child: Icon(
                    Icons.my_location,
                    size: 40,
                    color: AppTheme.primary,
                  ),
                ),
              ),
              Positioned(
                height: height * 0.25,
                width: width * 0.83,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  itemCount: eventListProvider.allEvents.length,
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.1,
                  ),
                  itemBuilder: (context, index) {
                    final event = eventListProvider.allEvents[index];
                    return InkWell(
                      onTap: () {
                        if (event.late != null && event.long != null) {
                          _centerMap(
                            newLatLng: LatLng(
                              double.parse(event.late!),
                              double.parse(event.long!),
                            ),
                          );
                        }
                      },
                      child: MapItem(event: event),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
