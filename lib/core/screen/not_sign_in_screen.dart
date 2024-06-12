import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../auth/screens/login_screen/login_screen.dart';

class NotSignInScreen extends StatelessWidget {
  const NotSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xffF0F5FA),
              child: Icon(
                Icons.lock,
                size: 40,
                color: Color(0xffD2D5F9),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Please Login",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "You need to login to access this page",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4624C2),
                fixedSize: const Size(200, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Sign in", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);

              },
                child: const Text("Back to Home ", style: TextStyle(color: Colors.blue),),),
          ],
        ),
      ),
    );
  }
}
