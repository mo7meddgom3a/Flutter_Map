import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shops/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:shops/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:shops/screens/home_screen/widgets/custom_appbar.dart';
import 'package:shops/screens/home_screen/widgets/custom_buttoms.dart';
import 'package:shops/screens/home_screen/widgets/custom_navigation_bar.dart';
import 'package:shops/screens/home_screen/widgets/image_slider_widget.dart';
import 'package:shops/screens/home_screen/widgets/map_widget.dart';
import 'package:shops/screens/home_screen/widgets/slider_widget.dart';

import '../../auth/screens/login_screen/login_screen.dart';
import '../seller_screen/seller_home_screen.dart';
import 'cubit/map_marker_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    context.read<MapMarkerCubit>().getCurrentLocation();
    context.read<MapMarkerCubit>().getAddressFromLatLng();
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return AdvancedDrawer(
            backdropColor: Colors.white,
            controller: _advancedDrawerController,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            animateChildDecoration: true,
            disabledGestures: false,
            childDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            drawer: SafeArea(
              child: ListTileTheme(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xffF0F5FA),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Color(0xffD2D5F9),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text("${state.user?.displayName}"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DropdownButton<String>(
                            iconEnabledColor: const Color(0xff4624C2),
                            items: <String>['العربية', 'English']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: const TextStyle(
                                        color: Color(0xff4624C2))),
                              );
                            }).toList(),
                            onChanged: (_) {},
                            hint: const Text('العربية',
                                style: TextStyle(color: Color(0xff4624C2))),
                          ),
                          const Spacer(),
                          const Text('اللغة'),
                          const SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset("assets/icon_images/lang.svg"),
                        ],
                      ),
                    ),
                    const Divider(),
                    CustomButton(
                      text: 'الاشعارات',
                      icon: "assets/icon_images/ic_round-notifications.svg",
                      onTap: () {},
                    ),
                    const Divider(),
                    CustomButton(
                      text: 'القائمة المفضلة',
                      icon: "assets/icon_images/favorite.svg",
                      onTap: () {},
                    ),
                    const Divider(),
                    CustomButton(
                      text: 'بريد',
                      icon: "assets/icon_images/phone.svg",
                      onTap: () {},
                    ),
                    const Divider(),
                    CustomButton(
                      text: 'الاعدادات',
                      icon: "assets/icon_images/sitting.svg",
                      onTap: () {},
                    ),
                    const Divider(),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff4624C2)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('مشاركة التطبيق'),
                          const SizedBox(width: 10),
                          SvgPicture.asset("assets/icon_images/share.svg"),
                        ],
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        context.read<SignInBloc>().add(const SignOutRequired());
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4624C2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'تسجيل الخروج',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
            rtlOpening: true,
            child: SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  // Added SingleChildScrollView here
                  child: Column(
                    children: [
                      CustomAppBar(
                          advancedDrawerController: _advancedDrawerController),
                      const MapScreen(),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      // slider range
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: ImageSlideshow(
                          children: [
                            Image.network(
                              "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      const CustomNavigationBar()
                    ],
                  ),
                ),
              ),
            ),
          );

        }else {
          return AdvancedDrawer(
            backdropColor: Colors.white,
            controller: _advancedDrawerController,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            animateChildDecoration: true,
            disabledGestures: false,
            childDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            drawer: SafeArea(
              child: ListTileTheme(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xffF0F5FA),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Color(0xffD2D5F9),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4624C2),
                        fixedSize: const Size(200, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'تسجيل الدخول',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SellerHomeScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4624C2),
                        fixedSize: const Size(200, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'تسجيل الدخول كتاجر',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DropdownButton<String>(
                            iconEnabledColor: const Color(0xff4624C2),
                            items: <String>['العربية', 'English']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: const TextStyle(
                                        color: Color(0xff4624C2))),
                              );
                            }).toList(),
                            onChanged: (_) {},
                            hint: const Text('العربية',
                                style: TextStyle(color: Color(0xff4624C2))),
                          ),
                          const Spacer(),
                          const Text('اللغة'),
                          const SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset("assets/icon_images/lang.svg"),
                        ],
                      ),
                    ),
                    const Divider(),
                    CustomButton(
                      text: 'الشروط و الأحكام',
                      icon: "assets/icon_images/conditions.svg",
                      onTap: () {},
                    ),
                    const Divider(),
                    CustomButton(
                      text: 'سياسة الخصوصية',
                      icon: "assets/icon_images/politics.svg",
                      onTap: () {},
                    ),
                    const Divider(),
                    CustomButton(
                      text: 'تواصل معنا',
                      icon: "assets/icon_images/phone.svg",
                      onTap: () {},
                    ),
                    const Divider(),
                    CustomButton(
                      text: 'الاشعارات',
                      icon: "assets/icon_images/ic_round-notifications.svg",
                      onTap: () {},
                    ),
                    const Divider(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff4624C2)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('مشاركة التطبيق'),
                          const SizedBox(width: 10),
                          SvgPicture.asset("assets/icon_images/share.svg"),
                        ],
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        context.read<SignInBloc>().add(SignOutRequired());
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4624C2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'تسجيل الخروج',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
            rtlOpening: true,
            child: SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomAppBar(
                          advancedDrawerController: _advancedDrawerController),
                      const MapScreen(),
                      const SliderWidget(),
                      const ImageSliderWidget(),
                      const CustomNavigationBar()
                    ],
                  ),
                ),
              ),
            ),
          );

        }
      },
    );
  }
}

