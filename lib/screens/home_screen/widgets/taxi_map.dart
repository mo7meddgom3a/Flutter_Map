import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/colors.dart';
import '../cubit/taxi_app_cubit.dart';

class TaxiMap extends StatelessWidget {
  final MapController mapController;
  final TaxiAppState state;
  final Function(LatLng) onMapTap;

  const TaxiMap({
    required this.mapController,
    required this.state,
    required this.onMapTap,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: state.currentLocation ?? const LatLng(45.521563, -122.677433),
        initialZoom: 13.0,
        onTap: (tapPosition, point) => onMapTap(point),
      ),
      children: [
        TileLayer(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: _buildMarkers(),
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: state.route,
              strokeWidth: 4.0,
              color: Colors.blue,
            ),
          ],
        ),
      ],
    );
  }

  List<Marker> _buildMarkers() {
    return [
      if (state.currentLocation != null)
        Marker(
          width: 80.0,
          height: 80.0,
          point: state.currentLocation!,
          child: const Icon(Icons.location_on, color: Colors.blue),
        ),
      if (state.pickUpLocation != null)
        Marker(
          width: 80.0,
          height: 80.0,
          point: state.pickUpLocation!,
          child: const Icon(Icons.location_on, color: Colors.green),
        ),
      if (state.destination != null)
        Marker(
          width: 80.0,
          height: 80.0,
          point: state.destination!,
          child: Icon(Icons.location_on, color: scheme.error),
        ),
    ];
  }
}
