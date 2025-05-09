import 'package:damnhour_university/icons/custom_icons.dart';
import 'package:damnhour_university/layout/layout.dart';
import 'package:damnhour_university/modules/register/register.dart';
import 'package:damnhour_university/modules/reset-password/forget_password.dart';
import 'package:damnhour_university/modules/login/cubit/login_cubit.dart';
import 'package:damnhour_university/modules/login/cubit/login_states.dart';
import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  Login({super.key});
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Fluttertoast.showToast(
              msg: state.model.message.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16,
            );
            navigateTo(to: LayoutScreen(), context: context);
          } else if (state is LoginErrorState) {
            Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16,
            );
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
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
                              Container(
                                child: TextCairo(text: "بجامعة دمنهور"),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Container(
                            height: 100,
                            child: Image(
                              image: AssetImage("assets/images/logo.png"),
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
                                        text: '!مرحبًا مجددًا',
                                        color: accent_orange,
                                        fontsize: 22,
                                      ),
                                      SizedBox(height: 3),
                                      TextCairo(
                                        text: 'حان وقت إحداث الفرق',
                                        color: Colors.black,
                                        fontsize: 14,
                                      ),
                                    ],
                                  ),
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomTextFeild(
                                        controller: emailcontroller,
                                        hinttext: ' ادخل البريد الالكتروني ',
                                        prefixicon: Icon(
                                          CustomIcons.mail_outline,
                                          color: primary_blue,
                                        ),
                                        toptext: 'البريد الالكتروني',
                                        Validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'البريد الإلكتروني مطلوب';
                                          }

                                          return null;
                                        },
                                      ),
                                      SizedBox(height: ScreenSize.height * .01),
                                      CustomTextFeild(
                                        suffixicon: InkWell(
                                          onTap: () {
                                            cubit.changePasswordVisibility();
                                          },
                                          child: Icon(
                                            cubit.isPasswordVisible
                                                ? CustomIcons.visibility
                                                : CustomIcons.visibility_off,
                                            color: Colors.black,
                                          ),
                                        ),
                                        controller: passwordcontroller,
                                        obscureText: !cubit.isPasswordVisible,
                                        hinttext: ' ******************** ',
                                        prefixicon: Icon(
                                          CustomIcons.lock_outline,
                                          color: primary_blue,
                                        ),
                                        toptext: 'كلمة المرور ',
                                        Validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'كلمة المرور مطلوبة';
                                          }
                                          if (value.length < 8) {
                                            return 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 30),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 30 / 375 * ScreenSize.width,
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        ForgetPassword(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'نسيت كلمة المرور؟',
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),
                                state is! LoginLoadingState
                                    ? Button(
                                      onpressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          cubit.userLogin(
                                            email: emailcontroller.text.trim(),
                                            password: passwordcontroller.text,
                                          );
                                        }
                                      },
                                      text: ' تسجيل الدخول ',
                                    )
                                    : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                SizedBox(height: ScreenSize.height * .01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: TextCairo(
                                        text: '!سجّل الآن وابدأ رحلتك',
                                        color: primary_blue,
                                        fontsize: 14,
                                        fontweight: FontWeight.w400,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Register(),
                                          ),
                                        );
                                      },
                                    ),
                                    TextCairo(
                                      text: ' ليس لديك حساب؟  ',
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
