import 'package:damnhour_university/modules/onboarding/onboarding.dart';
import 'package:damnhour_university/modules/splash/splash.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/cubit/bloc_observer.dart';
import 'package:damnhour_university/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    BlocProvider(
      create: (BuildContext context) => UniversityCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) {
            ScreenSize.initscreensize(context);
            return AnimatedSplashScreen(
              splash: Splash(),
              nextScreen: OnBoarding(),
              splashIconSize: 500,
              duration: 2000,
            );
          },
        ),
      ),
    ),
  );
}
