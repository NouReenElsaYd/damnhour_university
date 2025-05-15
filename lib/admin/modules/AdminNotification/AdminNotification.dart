import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AdminNotification extends StatelessWidget {
  const AdminNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextCairo(
              text: 'الاشعارات',
              fontsize: 18.0,
              color: primary_blue,
              textalign: TextAlign.end,
            ),
            SizedBox(width: ScreenSize.width * 0.02),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: ScreenSize.width * 0.05,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/undraw_notify_rnwe 1.svg',
              height: ScreenSize.height * 0.13,
              width: ScreenSize.width * 0.33,
            ),
            SizedBox(height: ScreenSize.height * 0.03),
            TextCairo(text: 'لا إشعارات حالياً', color: primary_blue),
            SizedBox(height: ScreenSize.height * 0.015),
            TextCairo(
              text: 'يبدو أن كل شيء يسير على ما يرام...',
              fontsize: 12.0,
              fontweight: FontWeight.w400,
              color: accent_orange,
            ),
          ],
        ),
      ),
    );
  }
}
