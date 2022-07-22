import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:syncfusion_flutter_maps/maps.dart';








class MapScreen extends StatelessWidget {



  // Method to  get the Latitude & longitude of User's location

  Future<LocationData?> _currentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;


    // creating object of package location

    Location location = new Location();

    // checking weather user allows permission or not !

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }


    // IF permission is granted then, then we request for the location


    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    return await location.getLocation();
  }




  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocationData?>(
      future: _currentLocation(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
        if (snapchat.hasData) {
          final LocationData currentLocation = snapchat.data;
          return SfMaps(
            layers: [
              MapTileLayer(

                // initial/User's location

                initialFocalLatLng: MapLatLng(
                    currentLocation.latitude!, currentLocation.longitude!),
                initialZoomLevel: 5,
                initialMarkersCount: 1,



                // 1. we will get our Integration Url from mapBox account
                // 2. We go to Styles create custom map and get the third party "CARTO" URl

                urlTemplate: 'https://api.mapbox.com/styles/v1/nikhil00/cl5uyhkry000u14pbpj8wsh3n/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibmlraGlsMDAiLCJhIjoiY2w1dXUxZW82MDNhYjNkbzRibHB4OWhpOSJ9.9ZK3ey9MyPNrfRv1W2rR3Q',
                markerBuilder: (BuildContext context, int index) {
                  return MapMarker(

                    // We drop the marker on Current location of the user

                    latitude: currentLocation.latitude!,
                    longitude: currentLocation.longitude!,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red[800],
                    ),
                    size: Size(20, 20),
                  );
                },
              ),
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );


  }
}

