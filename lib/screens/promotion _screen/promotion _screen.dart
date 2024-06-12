import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:shops/screens/home_screen/widgets/custom_appbar.dart';

import '../home_screen/widgets/image_slider_widget.dart';

class PromotionScreen extends StatelessWidget {
  PromotionScreen({super.key});

  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomAppBar(advancedDrawerController: _advancedDrawerController),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Anwar Supermarket',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text('السعودية',
                                    style: TextStyle(fontSize: 16)),
                                Text(
                                  'الرياض',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Icon(Icons.location_on, color: Colors.grey),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xffF0F5FA),
                      child: Icon(
                        Icons.person,
                        size: 20,
                        color: Color(0xffD2D5F9),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const ImageSliderWidget(),
               SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('1 day 15 hour 45 min 23 sec',
                      style: TextStyle(color: Colors.grey)),
                  Text('تبقى للخصم', style: TextStyle(color: Colors.grey)),
                  Icon(Icons.share, color: Colors.grey),
                  Text('20', style: TextStyle(color: Colors.grey)),
                  Icon(Icons.remove_red_eye, color: Colors.grey),
                  Text('20', style: TextStyle(color: Colors.grey)),
                ],
              ),
               SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              const ImageSliderWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
