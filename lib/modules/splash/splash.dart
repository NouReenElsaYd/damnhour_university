import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: true, appBarTheme: AppBarTheme()),
      child: splash(),
    );
  }
}

Widget splash() {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Center(
        child: Container(
          width: 125 / 375 * ScreenSize.width,
          height: 173 / 812 * ScreenSize.height,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/logo.png")),
          ),
        ),
      ),
    ],
  );
}
