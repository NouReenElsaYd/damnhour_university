import 'package:damnhour_university/icons/custom_icons.dart';
import 'package:damnhour_university/layout/layout.dart';
import 'package:damnhour_university/modules/login/login.dart';
import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  Register({super.key});
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController idcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

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
                                  text: '!انضم إلينا وكن جزءًا من الحل',
                                  color: accent_orange,
                                  fontsize: 22,
                                ),
                                SizedBox(height: 3),
                                TextCairo(
                                  text: 'املأ البيانات بالاسفل',
                                  color: Colors.black,
                                  fontsize: 14,
                                ),
                              ],
                            ),
                          ),
                          Form(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomTextFeild(
                                  controller: namecontroller,
                                  hinttext: ' الأسم الثلاثي',
                                  prefixicon: Icon(
                                    Icons.person_outline,
                                    color: primary_blue,
                                  ),
                                  toptext: 'الاسم',
                                ),
                                SizedBox(height: ScreenSize.height * .01),
                                CustomTextFeild(
                                  controller: emailcontroller,
                                  hinttext: ' ادخل البريد الالكتروني ',
                                  prefixicon: Icon(
                                    CustomIcons.mail_outline,
                                    color: primary_blue,
                                  ),
                                  toptext: 'البريد الالكتروني',
                                ),
                                SizedBox(height: ScreenSize.height * .01),
                                CustomTextFeild(
                                  controller: idcontroller,
                                  hinttext: ' الرقم القومي',
                                  prefixicon: Icon(
                                    CustomIcons.vcard,
                                    color: primary_blue,
                                  ),
                                  toptext: 'الرقم القومي',
                                ),
                                SizedBox(height: ScreenSize.height * .01),
                                CustomTextFeild(
                                  suffixicon: InkWell(
                                    onTap: () {},
                                    child: Icon(CustomIcons.visibility),
                                  ),
                                  controller: passwordcontroller,
                                  hinttext: ' ******************** ',
                                  prefixicon: Icon(
                                    CustomIcons.lock_outline,
                                    color: primary_blue,
                                  ),
                                  toptext: 'كلمة المرور ',
                                ),
                                SizedBox(height: ScreenSize.height * .01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextCairo(
                                      text:
                                          'أوافق على سياسة الاستخدام وأتعهد بتقديم شكاوى حقيقية',
                                      fontsize: 12,
                                      fontweight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    Checkbox(
                                      value: false,
                                      onChanged: (bool? value) {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 50),
                          Button(
                            onpressed: () {
                              navigateTo(to: LayoutScreen(), context: context);
                            },
                            text: ' تسجيل ',
                          ),
                          SizedBox(height: ScreenSize.height * .01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: TextCairo(
                                  text: 'تسجيل دخول',
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
                                text: '  لديك حساب بالفعل؟',
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
