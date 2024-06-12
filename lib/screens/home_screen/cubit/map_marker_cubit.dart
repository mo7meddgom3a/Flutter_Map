import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../models/map_marker_model.dart';

part 'map_marker_state.dart';

class MapMarkerCubit extends Cubit<MapMarkerState> {
  MapMarkerCubit() : super(const MapMarkerState());
  Position? _currentPosition;
  void fetchMarkers() {
    emit(state.copyWith(state: MapMarkerStatus.loading));
    try {
      final List<MapMarkerModel> markers = [
        MapMarkerModel(
          discount: 20,
          id: '1',
          name: 'Example place 1',
          description: 'This is an example place 1',
          position: const LatLng(26.774265, 45.738586),
        ),
        MapMarkerModel(
          discount: 10,
          id: '2',
          name: 'Example place 2',
          description: 'This is an example place 2',
          position: const LatLng(24.774265, 46.748586),
        ),
        MapMarkerModel(
          discount: 30,
          id: '3',
          name: 'Example place 3',
          description: 'This is an example place 3',
          position: const LatLng(25.764265, 44.738586),
        ),
        MapMarkerModel(
          discount: 40,
          id: '4',
          name: 'Example place 4',
          description: 'This is an example place 4',
          position: const LatLng(23.774265, 45.738586),
        ),
        MapMarkerModel(
          discount: 50,
          id: '5',
          name: 'Example place 5',
          description: 'This is an example place 5',
          position: const LatLng(26.774265, 46.738586),
        ),
        MapMarkerModel(
          discount: 60,
          id: '6',
          name: 'Example place 6',
          description: 'This is an example place 6',
          position: const LatLng(25.774265, 45.738586),
        ),
        MapMarkerModel(
          discount: 70,
          id: '7',
          name: 'Example place 7',
          description: 'This is an example place 7',
          position: const LatLng(24.774265, 44.738586),
        ),
        MapMarkerModel(
          discount: 80,
          id: '8',
          name: 'Example place 8',
          description: 'This is an example place 8',
          position: const LatLng(23.774265, 46.738586),
        ),
        MapMarkerModel(
          discount: 90,
          id: '9',
          name: 'Example place 9',
          description: 'This is an example place 9',
          position: const LatLng(26.774265, 44.738586),
        ),
        MapMarkerModel(
          discount: 100,
          id: '10',
          name: 'Example place 10',
          description: 'This is an example place 10',
          position: const LatLng(24.774265, 45.738586),
        ),
      ];
      emit(state.copyWith(state: MapMarkerStatus.loaded, markers: markers));
    } catch (e) {
      emit(state.copyWith(
          state: MapMarkerStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _currentPosition = position;

      if (_currentPosition != null) {
        emit(state.copyWith(
          currentLocation: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          locationFetched: true,
        ));
      } else {
        emit(state.copyWith(errorMessage: "Failed to fetch current location"));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> getAddressFromLatLng() async {
    emit(state.copyWith(state: MapMarkerStatus.loading));
    if (_currentPosition == null) {
      emit(state.copyWith(errorMessage: "Current position is null"));
      return;
    }
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      if (placeMarks.isNotEmpty) {
        Placemark place = placeMarks[0];
        emit(state.copyWith(
          currentLocationName: "${place.street}-${place.administrativeArea}-${place.country}",
        ));
      } else {
        emit(state.copyWith(errorMessage: ""));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  // void selectMarker(MapMarkerModel marker) {
  //   emit(state.copyWith(isMarkerSelected: marker));
  //
  // }
}
