import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paddle_jakarta/presentation/common/ui_helpers.dart';
import 'package:paddle_jakarta/presentation/views/home/viewmodels/home_viewmodel.dart';

class HomeCreateMatchScreen extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeCreateMatchScreen({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String mapStyle = jsonEncode([
      {
        "featureType": "landscape.natural",
        "elementType": "all",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "all",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "landscape.man_made",
        "elementType": "all",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "administrative",
        "elementType": "all",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "all",
        "stylers": [
          {
            "visibility": "on"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "all",
        "stylers": [
          {
            "color": "#00bcd4"
          }
        ]
      }
    ]);
    
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          verticalSpaceLarge,
          AspectRatio(
            aspectRatio: 9 / 11,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  viewModel.isLocationPermissionGranted
                  ? GoogleMap(
                    style: mapStyle,
                    initialCameraPosition: CameraPosition(
                      target: viewModel.currentPosition ?? const LatLng(-6.2088, 106.8456),
                      zoom: 15.0,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      if (viewModel.currentPosition != null) {
                        viewModel.updateCameraPosition(controller);
                      }
                    },
                  )
                  : _permissionDeniedNotice(viewModel),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _permissionDeniedNotice(HomeViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(child: Text('Location permission not granted',)),
        verticalSpaceSmall,
        Center(
          child: TextButton(
            onPressed: () async => await viewModel.checkLocationPermission(),
            child: const Text("Allow to access device's location"),
          ),
        ),
      ],
    );
  }
}
