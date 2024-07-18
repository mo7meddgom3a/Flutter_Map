import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shops/screens/home_screen/widgets/location_selection_box.dart';
import 'package:shops/screens/home_screen/widgets/taxi_map.dart';
import 'cubit/taxi_app_cubit.dart';

class HomeScreen extends StatelessWidget {
  final MapController _mapController = MapController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TaxiAppCubit>().getCurrentLocation();
    final cubit = context.read<TaxiAppCubit>();

    return Scaffold(
      body: BlocBuilder<TaxiAppCubit, TaxiAppState>(
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              TaxiMap(
                mapController: _mapController,
                state: state,
                onMapTap: (point) => _handleMapTap(context, state, point),
              ),
              Positioned(
                top: 50.0,
                left: 15.0,
                right: 15.0,
                child: LocationSelectionBox(cubit: cubit, state: state),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  void _handleMapTap(BuildContext context, TaxiAppState state, LatLng point) {
    final cubit = context.read<TaxiAppCubit>();
    if (state.mapTapMode == MapTapMode.pickUp) {
      cubit.setPickUpLocationFromMap(point);
    } else if (state.mapTapMode == MapTapMode.destination) {
      cubit.setDestinationFromMap(point);
    }
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
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
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return BlocBuilder<TaxiAppCubit, TaxiAppState>(
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
    );
  }
}



