part of 'taxi_app_cubit.dart';

enum MapTapMode { none, pickUp, destination }

class TaxiAppState extends Equatable{
  final LatLng? currentLocation;
  final LatLng? pickUpLocation;
  final LatLng? destination;
  final List<LatLng> route;
  final MapTapMode mapTapMode;
  final String? errorMessage;
  final bool isDestination;
  final bool isPickUp;

  TaxiAppState({
    this.currentLocation,
    this.pickUpLocation,
    this.destination,
    this.route = const [],
    this.mapTapMode = MapTapMode.none,
    this.errorMessage,
    this.isDestination = false,
    this.isPickUp = false,
  });

  TaxiAppState copyWith({
    LatLng? currentLocation,
    LatLng? pickUpLocation,
    LatLng? destination,
    List<LatLng>? route,
    MapTapMode? mapTapMode,
    String? errorMessage,
    String? currentLocationName,
    bool? isDestination,
    bool? isPickUp,
  }) {
    return TaxiAppState(
      currentLocation: currentLocation ?? this.currentLocation,
      pickUpLocation: pickUpLocation ?? this.pickUpLocation,
      destination: destination ?? this.destination,
      route: route ?? this.route,
      mapTapMode: mapTapMode ?? this.mapTapMode,
      errorMessage: errorMessage ?? this.errorMessage,
      isDestination: isDestination ?? this.isDestination,
      isPickUp: isPickUp ?? this.isPickUp,
    );
  }

  @override
  List<Object?> get props => [currentLocation, pickUpLocation, destination, route, mapTapMode , errorMessage  , isDestination , isPickUp];
}
