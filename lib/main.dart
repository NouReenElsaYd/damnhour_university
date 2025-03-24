import 'package:damnhour_university/modules/onboarding/onboarding.dart';
import 'package:damnhour_university/modules/splash/splash.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          ScreenSize.initscreensize(context);
          return AnimatedSplashScreen(
            splash: Splash(),
            nextScreen: OnBoarding(),
            splashIconSize: 500,
            duration: 3000,
          );
        },
      ),
    ),
  );
}
