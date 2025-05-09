import 'package:damnhour_university/icons/custom_icons.dart';
import 'package:damnhour_university/modules/login/cubit/login_cubit.dart';
import 'package:damnhour_university/modules/login/cubit/login_states.dart';
import 'package:damnhour_university/modules/login/login.dart';
import 'package:damnhour_university/modules/reset-password/otp.dart';
import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  TextEditingController emailcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),

      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is forgetpassSuccessState) {
            showtoast(
              message: state.model.message.toString(),
              color: Colors.green,
            );
            navigateTo(to: Otp(email: emailcontroller.text), context: context);
          } else if (state is forgetpassErrorState) {
            showtoast(message: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
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
                                Container(
                                  width: 327 / 375 * ScreenSize.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 15),
                                      TextCairo(
                                        textalign: TextAlign.center,
                                        text: '!لا تقلق، يمكننا مساعدتك',
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
                                Form(
                                  key: _formkey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomTextFeild(
                                        Validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'البريد الإلكتروني مطلوب';
                                          }
                                          return null;
                                        },
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
                                ),
                                SizedBox(height: 30),
                                state is! forgetpassLoadingState
                                    ? Button(
                                      onpressed: () {
                                        if (_formkey.currentState!.validate()) {
                                          LoginCubit.get(context).saveemail(
                                            email: emailcontroller.text,
                                          );
                                          LoginCubit.get(context).forgetpass(
                                            email: emailcontroller.text.trim(),
                                          );
                                        }
                                      },
                                      text: ' ارسال الرمز ',
                                    )
                                    : Center(
                                      child: CircularProgressIndicator(),
                                    ),
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
        },
      ),
    );
  }
}
