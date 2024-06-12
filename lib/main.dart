import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:shops/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:shops/core/screen/not_sign_in_screen.dart';
import 'package:shops/firebase_options.dart';
import 'package:shops/screens/home_screen/cubit/map_marker_cubit.dart';
import 'package:shops/screens/home_screen/cubit/slider_cubit.dart';
import 'package:shops/screens/home_screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shops/simple_bloc_observer.dart';

import 'auth/firebase_user_repo.dart';
import 'auth/screens/login_screen/login_screen.dart';
import 'auth/user_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(ShopLocations(FirebaseUserRepo()));
}

class ShopLocations extends StatelessWidget {
  const ShopLocations(this.userRepo, {super.key,});

  final UserRepo userRepo;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc(userRepo: userRepo)),
        BlocProvider(create: (context) => MapMarkerCubit()..fetchMarkers()),
        BlocProvider(create: (context) => SignInBloc(userRepository: context.read<AuthenticationBloc>().userRepo)),
        BlocProvider(create: (context) => SliderCubit()),
      ],
      child: MaterialApp(
        routes: {
          // '/': (context) => HomeScreen(),
          "NotSigned": (context) => const NotSignInScreen(),
          "LoginScreen": (context) => const LoginScreen(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Shop Locations',
        home: BlocProvider(
          create: (context) => SignInBloc(userRepository: context.read<AuthenticationBloc>().userRepo),
          child: HomeScreen(),
        ),
      ),
    );
  }
}
