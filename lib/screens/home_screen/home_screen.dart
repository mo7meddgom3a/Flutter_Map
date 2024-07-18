import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'cubit/taxi_app_cubit.dart';


class HomeScreen extends StatelessWidget {
  final MapController _mapController = MapController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger to get the current location when the screen is built
    context.read<TaxiAppCubit>().getCurrentLocation();
    final cubit = context.read<TaxiAppCubit>();
    return Scaffold(
      body: BlocBuilder<TaxiAppCubit, TaxiAppState>(
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              // FlutterMap widget for displaying the map
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  // Set initial center of the map to current location or a default location
                  initialCenter:
                  state.currentLocation ?? const LatLng(45.521563, -122.677433),
                  initialZoom: 13.0,
                  onTap: (tapPosition, point) {
                    // Handle map tap based on current mapTapMode
                    if (state.mapTapMode == MapTapMode.pickUp) {
                     cubit.setPickUpLocationFromMap(point);
                    } else if (state.mapTapMode == MapTapMode.destination) {
                     cubit.setDestinationFromMap(point);
                    }
                  },
                ),
                children: [
                  // Layers for displaying map tiles, markers, and polylines
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      // Marker for displaying current location
                      if (state.currentLocation != null)
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: state.currentLocation!,
                          child:  const Icon(Icons.location_on, color: Colors.blue),
                        ),
                      // Marker for displaying pick-up location
                      if (state.pickUpLocation != null)
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: state.pickUpLocation!,
                          child:  const Icon(Icons.location_on, color: Colors.green),
                        ),
                      // Marker for displaying destination location
                      if (state.destination != null)
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: state.destination!,
                          child:  const Icon(Icons.location_on, color: Colors.red),
                        ),
                    ],
                  ),
                  PolylineLayer(
                    polylines: [
                      // Polyline for displaying the route
                      Polyline(
                        points: state.route,
                        strokeWidth: 4.0,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 50.0,
                left: 15.0,
                right: 15.0,
                child: Container(
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
                      // TypeAheadField for selecting pick-up location
                      TypeAheadField<Location>(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: cubit.pickUpController,
                          decoration: InputDecoration(
                            hintText: 'Select pick up location',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.map),
                              color: state.mapTapMode == MapTapMode.pickUp ? Colors.green : Colors.black,
                              onPressed: () {
                                cubit.toggleMapTapMode(
                                  state.mapTapMode == MapTapMode.pickUp ? MapTapMode.none : MapTapMode.pickUp,
                                );
                              },
                            ),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          if (pattern.isEmpty) return [];
                          try {
                            return await locationFromAddress(pattern);
                          } catch (e) {
                            return [];
                          }
                        },
                        itemBuilder: (context, Location suggestion) {
                          return ListTile(
                            title: Text('${suggestion.latitude}, ${suggestion.longitude}'),
                          );
                        },
                        onSuggestionSelected: (Location suggestion) async {
                          List<Placemark> placeMarks = await placemarkFromCoordinates(
                              suggestion.latitude, suggestion.longitude);
                          if (placeMarks.isNotEmpty) {
                            String address = placeMarks.first.name ?? '${suggestion.latitude}, ${suggestion.longitude}';
                            cubit.setPickUpLocation(address, LatLng(suggestion.latitude, suggestion.longitude));
                          }
                        },
                      ),
                      const SizedBox(height: 10.0),
                      // TypeAheadField for selecting destination
                      TypeAheadField<Location>(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: cubit.destinationController,
                          decoration: InputDecoration(
                            hintText: 'Select destination',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.map),
                              color: state.mapTapMode == MapTapMode.destination ? Colors.green : Colors.black,
                              onPressed: () {
                                cubit.toggleMapTapMode(
                                  state.mapTapMode == MapTapMode.destination ? MapTapMode.none : MapTapMode.destination,
                                );
                              },
                            ),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          if (pattern.isEmpty) return [];
                          try {
                            return await locationFromAddress(pattern);
                          } catch (e) {
                            return [];
                          }
                        },
                        itemBuilder: (context, Location suggestion) {
                          return ListTile(
                            title: Text('${suggestion.latitude}, ${suggestion.longitude}'),
                          );
                        },
                        onSuggestionSelected: (Location suggestion) async {
                          List<Placemark> placemarks = await placemarkFromCoordinates(
                              suggestion.latitude, suggestion.longitude);
                          if (placemarks.isNotEmpty) {
                            String address = placemarks.first.name ?? '${suggestion.latitude}, ${suggestion.longitude}';
                            cubit.setDestination(address, LatLng(suggestion.latitude, suggestion.longitude));
                          }
                        },
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              cubit.findRider();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            ),
                            child: const Text('Find Rider', style: TextStyle(color: Colors.white)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              cubit.clearRider();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            ),
                            child: const Text('Clear Rider', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      // Bottom navigation bar for navigating between different screens
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Rides',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          // Handle bottom navigation bar tap
        },
      ),
      // Floating action button for moving the map to the current location
      floatingActionButton: BlocBuilder<TaxiAppCubit, TaxiAppState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              _mapController.move(
                state.currentLocation ?? const LatLng(45.521563, -122.677433),
                13.0,
              );
            },
            child: const Icon(Icons.my_location),
          );
        },
      ),
    );
  }
}
