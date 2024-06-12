import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shops/screens/home_screen/cubit/map_marker_cubit.dart';

class CustomAppBar extends StatelessWidget {
  final AdvancedDrawerController advancedDrawerController;

  const CustomAppBar({super.key, required this.advancedDrawerController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff4624C2),
      height: MediaQuery.of(context).size.height * 0.08,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/icon_images/Rectangle 4.png"),
            BlocBuilder<MapMarkerCubit, MapMarkerState>(
              builder: (context, state) {
                return Row(
                  children: [
                    InkWell(
                      child:SvgPicture.asset("assets/icon_images/Location.svg"),
                      // onTap: () {
                      //    context.read<MapMarkerCubit>().getCurrentLocation();
                      //   context.read<MapMarkerCubit>().getAddressFromLatLng();                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      state.currentLocationName,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    )
                  ],
                );
              },
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  advancedDrawerController.showDrawer();
                },
                child: SvgPicture.asset("assets/icon_images/Hamburger.svg"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
