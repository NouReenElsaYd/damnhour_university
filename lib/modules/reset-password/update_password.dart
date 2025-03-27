import 'package:damnhour_university/modules/login/login.dart';
import 'package:damnhour_university/modules/reset-password/updated_success.dart';
import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:damnhour_university/icons/custom_icons.dart';
import 'package:flutter/material.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

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
                                  text: 'أدخل كلمة مرور جديدة',
                                  color: accent_orange,
                                  fontsize: 22,
                                  fontweight: FontWeight.w700,
                                ),
                                SizedBox(height: 3),
                                TextCairo(
                                  textalign: TextAlign.center,
                                  text:
                                      'قم بتعيين كلمة مرور قوية لحماية حسابك. تأكد من اختيار ',
                                  color: Colors.black,
                                  fontsize: 14,
                                ),
                                TextCairo(
                                  textalign: TextAlign.center,
                                  text: '!كلمة مرور لا تنساها',
                                  color: Colors.black,
                                  fontsize: 14,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: ScreenSize.height * .05),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                CustomTextFeild(
                                  controller: newPasswordController,
                                  hinttext: ' ******************** ',
                                  prefixicon: Icon(
                                    CustomIcons.lock_outline,
                                    color: primary_blue,
                                  ),
                                  suffixicon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isNewPasswordVisible =
                                            !isNewPasswordVisible;
                                      });
                                    },
                                    child: Icon(
                                      isNewPasswordVisible
                                          ? CustomIcons.visibility
                                          : CustomIcons.visibility_off,
                                      color: Colors.black,
                                    ),
                                  ),
                                  toptext: 'كلمة المرور الجديدة',
                                ),
                                SizedBox(height: 20),
                                CustomTextFeild(
                                  controller: confirmPasswordController,
                                  hinttext: ' ******************** ',
                                  prefixicon: Icon(
                                    CustomIcons.lock_outline,
                                    color: primary_blue,
                                  ),
                                  suffixicon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isConfirmPasswordVisible =
                                            !isConfirmPasswordVisible;
                                      });
                                    },
                                    child: Icon(
                                      isConfirmPasswordVisible
                                          ? CustomIcons.visibility
                                          : CustomIcons.visibility_off,
                                      color: Colors.black,
                                    ),
                                  ),
                                  toptext: 'تأكيد كلمة المرور الجديدة',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: ScreenSize.height * .05),
                          Button(
                            onpressed: () {
                              navigateTo(
                                to: UpdatedSuccess(),
                                context: context,
                              );
                            },
                            text: 'تحديث كلمة المرور',
                          ),
                          SizedBox(height: ScreenSize.height * .03),
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
                          SizedBox(height: ScreenSize.height * .02),
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
