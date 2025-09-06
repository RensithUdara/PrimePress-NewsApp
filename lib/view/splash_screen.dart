import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infosphere/animation/fade_animation.dart';
import 'package:infosphere/utils/nav_bar.dart';

import 'package:infosphere/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

//https://dribbble.com/shots/15193792-News-iOS-mobile-app   ui
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 15), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NavBar()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myheight = MediaQuery.sizeOf(context).height * 1;
    final mywidth = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeAnimation(
            1.2,
            Container(
              height: MediaQuery.sizeOf(context).height,
              child: Image.asset(
                'assets/images/gif3.gif',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
