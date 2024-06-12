import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops/screens/home_screen/widgets/custom_navigation_icons.dart';

import '../../../auth/blocs/authentication_bloc/authentication_bloc.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff4624C2),
      ),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomNavigationIcons(
                onTap: () {
                  if (state.status == AuthenticationStatus.authenticated) {
                    print("Authenticated");
                  }else {
                    Navigator.pushNamed(context, "NotSigned");
                  }
                },
                image: "assets/icon_images/share-2.svg",
                text: "مشاركة التطبيق",
              ),
              CustomNavigationIcons(
                onTap: () {
                  if (state.status == AuthenticationStatus.authenticated) {
                    print("Authenticated");
                  }else {
                    Navigator.pushNamed(context, "NotSigned");
                  }
                },
                image: "assets/icon_images/briefcase.svg",
                text: "العروض",
              ),
              CustomNavigationIcons(
                onTap: () {
                  if (state.status == AuthenticationStatus.authenticated) {
                    print("Authenticated");
                  }else {
                    Navigator.pushNamed(context, "NotSigned");
                  }
                },
                image: "assets/icon_images/shopping-bag.svg",
                text: "الخصومات",
              ),
              CustomNavigationIcons(
                onTap: () {
                  if (state.status == AuthenticationStatus.authenticated) {
                    print("Authenticated");
                  }else {
                    Navigator.pushNamed(context, "NotSigned");
                  }
                },
                image: "assets/icon_images/user.svg",
                text: "حسابي",
              )
            ],
          );
        },
      ),
    );
  }
}
