import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

import '../cubit/taxi_app_cubit.dart';
import 'action_buttons.dart';
import 'location_inputField.dart';

class LocationSelectionBox extends StatelessWidget {
  final TaxiAppCubit cubit;
  final TaxiAppState state;

  const LocationSelectionBox({super.key, required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          const Text(
            'Select location',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          LocationInputField(
            controller: cubit.pickUpController,
            hintText: 'Select pick up location',
            isActive: state.mapTapMode == MapTapMode.pickUp,
            onToggleMapTapMode: () => cubit.toggleMapTapMode(
              state.mapTapMode == MapTapMode.pickUp ? MapTapMode.none : MapTapMode.pickUp,
            ),
            onSuggestionSelected: (suggestion) async {
              List<Placemark> placeMarks = await placemarkFromCoordinates(
                  suggestion.latitude, suggestion.longitude);
              if (placeMarks.isNotEmpty) {
                String address = placeMarks.first.name ?? '${suggestion.latitude}, ${suggestion.longitude}';
                cubit.setPickUpLocation(address, LatLng(suggestion.latitude, suggestion.longitude));
              }
            },
          ),
          const SizedBox(height: 10.0),
          LocationInputField(
            controller: cubit.destinationController,
            hintText: 'Select destination',
            isActive: state.mapTapMode == MapTapMode.destination,
            onToggleMapTapMode: () => cubit.toggleMapTapMode(
              state.mapTapMode == MapTapMode.destination ? MapTapMode.none : MapTapMode.destination,
            ),
            onSuggestionSelected: (suggestion) async {
              List<Placemark> placeMarks = await placemarkFromCoordinates(
                  suggestion.latitude, suggestion.longitude);
              if (placeMarks.isNotEmpty) {
                String address = placeMarks.first.name ?? '${suggestion.latitude}, ${suggestion.longitude}';
                cubit.setDestination(address, LatLng(suggestion.latitude, suggestion.longitude));
              }
            },
          ),
          const SizedBox(height: 10.0),
          ActionButtons(cubit: cubit),
        ],
      ),
    );
  }
}
