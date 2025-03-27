import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: ScreenSize.height * 0.055,
              start: ScreenSize.width * 0.04,
              end: ScreenSize.width * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: accentColor50,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications_none,
                          color: primary_blue,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextCairo(
                            text: 'جامعة دمنهور',
                            color: accent_orange,
                            fontweight: FontWeight.w400,
                            fontsize: 13.0,
                          ),
                          TextCairo(
                            text: 'الشكاوي والمقترحات',
                            color: Colors.black,
                            fontweight: FontWeight.w500,
                            fontsize: 16.0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Container(
                      height: 52,
                      child: Image(image: AssetImage("assets/images/logo.png")),
                    ),
                  ],
                ),
                SizedBox(height: ScreenSize.height * .02),
                TextCairo(
                  text: 'أبرز الشكاوي والاقتراحات',
                  color: Colors.black,
                  fontsize: 18.0,
                  fontweight: FontWeight.w500,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsetsDirectional.only(
              end: ScreenSize.width * 0.04,
              bottom: ScreenSize.height * 0.02,
            ),
            child: sectorsListView(),
          ),
          Container(height: 1.0, color: brandColor25),
        ],
      ),
    );
  }
}
