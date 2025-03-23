import 'package:damnhour_university/icons/custom_icons.dart';
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
            Stack(
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
                  height: .8 * ScreenSize.height,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 327 / 375 * ScreenSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                      Column(
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
                          CustomTextFeild(
                            controller: emailcontroller,
                            hinttext: ' ادخل البريد الالكتروني ',
                            prefixicon: Icon(
                              CustomIcons.mail_outline,
                              color: primary_blue,
                            ),
                            toptext: 'البريد الالكتروني',
                          ),
                          CustomTextFeild(
                            controller: idcontroller,
                            hinttext: ' الرقم القومي',
                            prefixicon: Icon(
                              CustomIcons.vcard,
                              color: primary_blue,
                            ),
                            toptext: 'الرقم القومي',
                          ),
                          CustomTextFeild(
                            suffixicon: InkWell(
                              onTap: () {},
                              child: Icon(CustomIcons.visibility),
                            ),
                            controller: passwordcontroller,
                            hinttext: ' كلمة المرور ',
                            prefixicon: Icon(
                              CustomIcons.lock_outline,
                              color: primary_blue,
                            ),
                            toptext: 'كلمة المرور ',
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'أوافق على سياسة الاستخدام وأتعهد بتقديم شكوى حقيقية',
                                style: TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Checkbox(
                                value: false,
                                onChanged: (bool? value) {},
                              ),
                            ],
                          ),
                        ],
                      ),

                      Button(onpressed: () {}, text: ' تسجيل '),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
