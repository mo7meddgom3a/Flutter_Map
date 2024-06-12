import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shops/screens/home_screen/cubit/map_marker_cubit.dart';
import 'package:shops/screens/home_screen/cubit/slider_cubit.dart';
import 'package:shops/screens/home_screen/widgets/promotion_buttom_sheet.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    await _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }
  }

  OverlayEntry _createOverlayEntry(BuildContext context, Offset position) {
    return OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy,
        child: Material(
          elevation: 4.0,
          child: Container(
            width: 200,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Icon(Icons.local_offer, color: Colors.red),
                    SizedBox(width: 5),
                    Text(
                      'Anwar Shop',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(5, (index) {
                    return const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                ),
                const SizedBox(height: 10),
                const Text(
                  '20% OFF',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _removeOverlay();
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.0),
                        ),
                      ),
                      builder: (context) {
                        return const PromotionBottomSheet();
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 40),
                    backgroundColor: const Color(0xFF6C63FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'المزيد',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOverlay(BuildContext context, Offset position) {
    _removeOverlay();
    _overlayEntry = _createOverlayEntry(context, position);
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderCubit, SliderState>(
      builder: (context, state) {
        final discountRange = state.newValues;
        return BlocBuilder<MapMarkerCubit, MapMarkerState>(
          builder: (context, state) {
            final filteredMarkers = state.markers.where((marker) {
              return marker.discount >= discountRange.start &&
                  marker.discount <= discountRange.end;
            }).toList();
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: state.locationFetched
                  ? FlutterMap(
                      options: MapOptions(
                        initialCenter: state.currentLocation,
                        initialZoom: 14.0,
                        onTap: (tapPosition, latLng) {
                          _removeOverlay();
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              width: 80.0,
                              height: 80.0,
                              point: state.currentLocation,
                              child: const Icon(Icons.location_on,
                                  color: Colors.red),
                            ),
                            ...filteredMarkers.map(
                              (marker) {
                                return Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: marker.position,
                                  child: Builder(
                                    builder: (context) => GestureDetector(
                                      onTap: () {
                                        RenderBox renderBox = context
                                            .findRenderObject() as RenderBox;
                                        Offset markerPosition = renderBox
                                            .localToGlobal(Offset.zero);
                                        Size markerSize = renderBox.size;
                                        Offset overlayPosition =
                                            markerPosition.translate(
                                          markerSize.width / 2,
                                          -markerSize.height / 2,
                                        );
                                        _showOverlay(context, overlayPosition);
                                      },
                                      child: Stack(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icon_images/Union.svg',
                                            color: const Color(0xff606161),
                                            height: 40.0,
                                            width: 40.0,
                                          ),
                                          Positioned(
                                            left: 7.0,
                                            top: 7.0,
                                            child: Image.asset(
                                              'assets/icon_images/rabais 1.png',
                                              color: Colors.white,
                                              height: 20.0,
                                              width: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    );
  }
}
