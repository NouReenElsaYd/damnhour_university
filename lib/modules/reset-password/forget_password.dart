import 'package:damnhour_university/icons/custom_icons.dart';
import 'package:damnhour_university/modules/login/login.dart';
import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  TextEditingController emailcontroller = TextEditingController();

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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: TextCairo(
                            text: "نظام إدارة الشكاوي و المقترحات",
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(child: TextCairo(text: "بجامعة دمنهور")),
                      ],
                    ),
                    SizedBox(width: 20),
                    Container(
                      height: 100,
                      child: Image(image: AssetImage("assets/images/logo.png")),
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
                          Container(
                            width: 327 / 375 * ScreenSize.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 15),
                                TextCairo(
                                  text: '!لا تقلق، يمكننا  مساعدتك',
                                  color: accent_orange,
                                  fontsize: 22,
                                  fontweight: FontWeight.w700,
                                ),
                                SizedBox(height: 3),
                                TextCairo(
                                  textalign: TextAlign.center,
                                  text:
                                      'أدخل بريدك الإلكتروني وسنرسل لك رابطًا لإعادة تعيين',
                                  color: Colors.black,
                                  fontsize: 14,
                                ),
                                TextCairo(
                                  textalign: TextAlign.center,
                                  text: 'كلمة المرور',
                                  color: Colors.black,
                                  fontsize: 14,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: ScreenSize.height * .02),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomTextFeild(
                                controller: emailcontroller,
                                hinttext: ' ادخل البريد الالكتروني ',
                                prefixicon: Icon(
                                  CustomIcons.mail_outline,
                                  color: primary_blue,
                                ),
                                toptext: 'البريد الالكتروني',
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Button(onpressed: () {}, text: ' ارسال الرمز '),
                          SizedBox(height: ScreenSize.height * .02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: TextCairo(
                                  text: '!سجّل الدخول الآن',
                                  color: primary_blue,
                                  fontsize: 14,
                                  fontweight: FontWeight.w400,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ),
                                  );
                                },
                              ),
                              TextCairo(
                                text: 'تذكرت كلمة المرور؟',
                                color: brandcolor_100,
                                fontsize: 14,
                                fontweight: FontWeight.w400,
                              ),
                            ],
                          ),
                          SizedBox(height: ScreenSize.height * .01),
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
