import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../auth/screens/create_account_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      final _currentUser = FirebaseAuth.instance.currentUser;

      if (_currentUser?.email != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const HomeScreen() //ReviewCart()
                ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const CreateAccountScreen() //ReviewCart()
                ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.red,
            width: size.width * 100,
            height: size.height * 100,
          ),
          Center(
            child: RichText(
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Social',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway-Medium',
                        fontSize: 30.0),
                  ),
                  TextSpan(
                    text: ' X',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway-Bold',
                        fontWeight: FontWeight.bold,
                        fontSize: 46.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
