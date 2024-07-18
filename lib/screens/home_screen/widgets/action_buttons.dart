import 'package:flutter/material.dart';

import '../cubit/taxi_app_cubit.dart';

class ActionButtons extends StatelessWidget {
  final TaxiAppCubit cubit;

  const ActionButtons({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: cubit.findRider,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          ),
          child: const Text('Find Rider', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: cubit.clearRider,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          ),
          child: const Text('Clear Rider', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
