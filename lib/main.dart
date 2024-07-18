import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops/screens/home_screen/cubit/taxi_app_cubit.dart';
import 'package:shops/screens/home_screen/home_screen.dart';
import 'package:shops/simple_bloc_observer.dart';
import 'core/routing_service.dart';

void main() async {
  // Bloc.observer = SimpleBlocObserver();
  runApp(ShopLocations());
}

class ShopLocations extends StatelessWidget {
  const ShopLocations( {super.key,});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taxi',
      home: BlocProvider(
        create: (_) => TaxiAppCubit(RoutingService())..getCurrentLocation(),
        child: HomeScreen(),
      ),
    );
  }
}
