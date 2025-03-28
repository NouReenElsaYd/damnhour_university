import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          SizedBox(height: ScreenSize.height * 0.1),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: SvgPicture.asset(
                      "assets/images/complain.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextCairo(
                    text: 'لا يوجد شكاوي حتى الآن! هل لديك أي ملاحظات أو',
                    color: Colors.black,
                    fontsize: 16,
                    fontweight: FontWeight.w500,
                  ),
                  SizedBox(height: 8),
                  TextCairo(
                    text: 'اقتراحات؟ اضغط على الزر ادناه وشاركنا رأيك ',
                    color: Colors.black54,
                    fontsize: 14,
                    fontweight: FontWeight.w400,
                  ),
                  SizedBox(height: 30),
                  Button(onpressed: () {}, text: 'تقديم اقتراح'),
                  SizedBox(height: 16),
                  Button(
                    onpressed: () {},
                    text: 'تقديم شكوى',
                    color: Colors.white,
                    textcolor: primary_blue,
                  ),
                  SizedBox(height: ScreenSize.height * 0.1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
