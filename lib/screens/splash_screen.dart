import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'on_boarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: 'Montserrat',
      ),
      child: AnimatedSplashScreen(
        splash: Column(
          children: [
            Expanded(
              child: Center(
                child: Lottie.asset(
                    'assets/images/splash_screen.json',
                    animate: true,
                    repeat: true,
                    reverse: true,
                    fit: BoxFit.cover
                ),
              ),
            ),
          ],
        ),
        nextScreen: const OnboardingScreen(),
        splashIconSize: 600,
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor:HexColor('#e4caaa'),
      ),
    );
  }
}