import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paddle_jakarta/presentation/common/ui_helpers.dart';
import 'package:paddle_jakarta/presentation/views/home/viewmodels/home_viewmodel.dart';

class HomeCreateMatchScreen extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomeCreateMatchScreen({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ListView(
        children: [
          Text('Create a match', style: Theme.of(context).textTheme.titleLarge),
          verticalSpaceLarge,
          AspectRatio(
            aspectRatio: 9 / 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(-6.2088, 106.8456),
                  zoom: 12.0,
                ),
              )
            ),
          )
        ],
      )
    );
  }

}