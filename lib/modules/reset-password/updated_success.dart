import 'package:damnhour_university/modules/login/login.dart';
import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UpdatedSuccess extends StatelessWidget {
  const UpdatedSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primary_blue,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            child: TextCairo(
                              textalign: TextAlign.center,
                              text:
                                  " نظام إدارة الشكاوي و المقترحات \n بجامعه دمنهور",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 100,
                        child: Image(
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: ScreenSize.width - 48,
                    height: .7 * ScreenSize.height + 20,
                    decoration: BoxDecoration(
                      color: brand,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    width: ScreenSize.width,
                    height: .7 * ScreenSize.height,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: .1 * ScreenSize.height),
                          Container(
                            width: 285 / 375 * ScreenSize.width,
                            height: 140 / 582 * .7 * ScreenSize.height,
                            child: SvgPicture.asset(
                              "assets/images/success.svg",
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 327 / 375 * ScreenSize.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextCairo(
                                  textalign: TextAlign.center,
                                  text: '!تم تحديث كلمة المرور بنجاح',
                                  color: accent_orange,
                                  fontsize: 22,
                                  fontweight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          Button(
                            onpressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                                (route) => false,
                              );
                            },
                            text: 'العودة لتسجيل الدخول',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
