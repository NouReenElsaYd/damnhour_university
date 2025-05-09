// ignore_for_file: must_be_immutable

import 'package:damnhour_university/modules/login/cubit/login_cubit.dart';
import 'package:damnhour_university/modules/login/cubit/login_states.dart';
import 'package:damnhour_university/modules/login/login.dart';
import 'package:damnhour_university/modules/reset-password/updated_success.dart';
import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:damnhour_university/icons/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePassword extends StatelessWidget {
  final String email;
  UpdatePassword({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is ResetPassSuccessState) {
            navigateTo(to: UpdatedSuccess(), context: context);
          } else if (state is LoginErrorState) {
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Form(
                                    key: _formkey,
                                    child: Column(
                                      children: [
                                        CustomTextFeild(
                                          Validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'كلمة المرور مطلوبة';
                                            }
                                            if (value.length < 8) {
                                              return ' يجب أن تكون كلمة المرور 8 أحرف على الأقل مع ارقام';
                                            }
                                            return null;
                                          },
                                          controller: newPasswordController,
                                          obscureText:
                                              !LoginCubit.get(
                                                context,
                                              ).isPasswordVisible,
                                          hinttext: ' ******************** ',
                                          prefixicon: Icon(
                                            CustomIcons.lock_outline,
                                            color: primary_blue,
                                          ),
                                          suffixicon: StatefulBuilder(
                                            builder: (context, setState) {
                                              return InkWell(
                                                onTap: () {
                                                  LoginCubit.get(
                                                    context,
                                                  ).changePasswordVisibility();
                                                },
                                                child: Icon(
                                                  LoginCubit.get(
                                                        context,
                                                      ).isPasswordVisible
                                                      ? CustomIcons.visibility
                                                      : CustomIcons
                                                          .visibility_off,
                                                  color: Colors.black,
                                                ),
                                              );
                                            },
                                          ),
                                          toptext: 'كلمة المرور الجديدة',
                                        ),
                                        SizedBox(height: 20),
                                        CustomTextFeild(
                                          Validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'كلمة المرور مطلوبة';
                                            }
                                            if (value.length < 8) {
                                              return ' يجب أن تكون كلمة المرور 8 أحرف على الأقل مع ارقام';
                                            }
                                            return null;
                                          },
                                          controller: confirmPasswordController,
                                          obscureText:
                                              !LoginCubit.get(
                                                context,
                                              ).isPasswordVisible,
                                          hinttext: ' ******************** ',
                                          prefixicon: Icon(
                                            CustomIcons.lock_outline,
                                            color: primary_blue,
                                          ),
                                          suffixicon: StatefulBuilder(
                                            builder: (context, setState) {
                                              return InkWell(
                                                onTap: () {
                                                  LoginCubit.get(
                                                    context,
                                                  ).changePasswordVisibility();
                                                },
                                                child: Icon(
                                                  LoginCubit.get(
                                                        context,
                                                      ).isPasswordVisible
                                                      ? CustomIcons.visibility
                                                      : CustomIcons
                                                          .visibility_off,
                                                  color: Colors.black,
                                                ),
                                              );
                                            },
                                          ),
                                          toptext: 'تأكيد كلمة المرور الجديدة',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: ScreenSize.height * .05),
                                state is! ResetPassLoadingState
                                    ? Button(
                                      onpressed: () {
                                        if (_formkey.currentState!.validate()) {
                                          if (LoginCubit.get(
                                            context,
                                          ).checkispassmatch(
                                            confirmpass:
                                                confirmPasswordController.text,
                                            newpass: newPasswordController.text,
                                          )) {
                                            LoginCubit.get(
                                              context,
                                            ).resetpassword(
                                              email: email,
                                              new_password:
                                                  newPasswordController.text,
                                              confirm_password:
                                                  confirmPasswordController
                                                      .text,
                                            );
                                          }
                                        }
                                      },
                                      text: 'تحديث كلمة المرور',
                                    )
                                    : Center(
                                      child: CircularProgressIndicator(),
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
        },
      ),
    );
  }
}
