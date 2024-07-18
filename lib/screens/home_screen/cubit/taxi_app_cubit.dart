import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/routing_service.dart';

part 'taxi_app_state.dart';

class TaxiAppCubit extends Cubit<TaxiAppState> {
  final RoutingService routingService;

  final TextEditingController pickUpController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  Position? _currentPosition;


  TaxiAppCubit(this.routingService) : super(TaxiAppState());

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _currentPosition = position;

      if (_currentPosition != null) {
        emit(state.copyWith(
          currentLocation: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        ));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
  void setPickUpLocationFromMap(LatLng point) {
    emit(state.copyWith(pickUpLocation: point, mapTapMode: MapTapMode.none));
    pickUpController.text = '${point.latitude}, ${point.longitude}';
  }

  void setDestinationFromMap(LatLng point) {
    emit(state.copyWith(destination: point, mapTapMode: MapTapMode.none));
    destinationController.text = '${point.latitude}, ${point.longitude}';
  }

  Future<void> setPickUpLocation(String address, LatLng point) async {
    pickUpController.text = address;
    emit(state.copyWith(pickUpLocation: point));
  }

  Future<void> setDestination(String address, LatLng point) async {
    destinationController.text = address;
    emit(state.copyWith(destination: point));
  }

  // void toggleMapTapMode(MapTapMode mode) {
  //   emit(state.copyWith(
  //     mapTapMode: mode,
  //     isPickUp: mode == MapTapMode.pickUp,
  //     isDestination: mode == MapTapMode.destination,
  //   ));
  // }

  void toggleMapTapMode(MapTapMode mode) {
    bool isToggled = mode == MapTapMode.destination && state.mapTapMode != MapTapMode.destination;
    emit(state.copyWith(mapTapMode: mode, isDestination: isToggled , isPickUp: !isToggled));
  }


  void clearRider() {
    destinationController.clear();
    pickUpController.clear();
    emit(TaxiAppState(currentLocation: state.currentLocation));
  }

  Future<void> findRider() async {
    if (state.pickUpLocation != null && state.destination != null) {
      try {
        List<LatLng> route = await routingService.getRouteCoordinates(state.pickUpLocation!, state.destination!);
        emit(state.copyWith(route: route,));
      } catch (e) {
        emit(state.copyWith(route: []));
      }
    }
  }

}
