part of 'map_marker_cubit.dart';

enum MapMarkerStatus { initial, loading, loaded, error }

class MapMarkerState extends Equatable {
  final MapMarkerStatus state;
  final List<MapMarkerModel> markers;
  final String? errorMessage;
  final LatLng currentLocation;
  final bool locationFetched;
  final String currentLocationName;
  const MapMarkerState({
    this.currentLocation = const LatLng(24.774265, 46.738586),
    this.state = MapMarkerStatus.initial,
    this.markers = const [],
    this.errorMessage,
    this.locationFetched = false,
    this.currentLocationName = "",
  });

  MapMarkerState copyWith({
    MapMarkerStatus? state,
    List<MapMarkerModel>? markers,
    String? errorMessage,
    LatLng? currentLocation,
    bool? locationFetched,
    String? currentLocationName,
  }) {
    return MapMarkerState(
      currentLocation: currentLocation ?? this.currentLocation,
      state: state ?? this.state,
      markers: markers ?? this.markers,
      errorMessage: errorMessage ?? this.errorMessage,
      locationFetched: locationFetched ?? this.locationFetched,
      currentLocationName: currentLocationName ?? this.currentLocationName,
    );
  }
  @override
  List<Object?> get props => [
        state,
        markers,
        errorMessage,
        currentLocation,
        locationFetched,
        currentLocationName,
      ];
}
