import 'package:damnhour_university/modules/login/cubit/login_cubit.dart';
import 'package:damnhour_university/modules/login/cubit/login_states.dart';
import 'package:damnhour_university/modules/login/login.dart';
import 'package:damnhour_university/modules/reset-password/update_password.dart';
import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class Otp extends StatelessWidget {
  String email;
  Otp({super.key, required this.email});
  TextEditingController firstnumber = TextEditingController();
  TextEditingController secondnumber = TextEditingController();
  TextEditingController thirdnumber = TextEditingController();
  TextEditingController forthnumber = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is OTPSuccessState) {
            showtoast(
              message: state.model.message.toString(),
              color: Colors.green,
            );
            navigateTo(to: UpdatePassword(email: email), context: context);
          } else if (state is OTPErrorState) {
            showtoast(message: state.error, color: Colors.red);
          } else if (state is forgetpassErrorState) {
            showtoast(message: state.error, color: Colors.red);
          } else if (state is forgetpassSuccessState) {
            showtoast(
              color: Colors.green,
              message: state.model.message.toString(),
            );
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
                                        text: '!تحقق من بريدك الإلكتروني',
                                        color: accent_orange,
                                        fontsize: 22,
                                        fontweight: FontWeight.w700,
                                      ),
                                      SizedBox(height: 3),
                                      TextCairo(
                                        textalign: TextAlign.center,
                                        text:
                                            'لقد أرسلنا لك رابطًا لإعادة تعيين كلمة المرور. يرجى التحقق',
                                        color: Colors.black,
                                        fontsize: 14,
                                      ),
                                      TextCairo(
                                        textalign: TextAlign.center,
                                        text: 'من بريدك الإلكتروني',
                                        color: Colors.black,
                                        fontsize: 14,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: ScreenSize.height * .05),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 272 / 375 * ScreenSize.width,
                                      child: Form(
                                        child: Form(
                                          key: _formkey,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              OtpInput(context, firstnumber),
                                              OtpInput(context, secondnumber),
                                              OtpInput(context, thirdnumber),
                                              OtpInput(context, forthnumber),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: ScreenSize.height * .05),
                                state is! OTPLoadingState
                                    ? Button(
                                      onpressed: () {
                                        if (_formkey.currentState!.validate()) {
                                          final OTP =
                                              firstnumber.text +
                                              secondnumber.text +
                                              thirdnumber.text +
                                              forthnumber.text;
                                          print(OTP);
                                          print(email);
                                          LoginCubit.get(
                                            context,
                                          ).verifyOTP(email: email, otp: OTP);
                                        }
                                      },
                                      text: ' التحقق ',
                                    )
                                    : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                SizedBox(height: ScreenSize.height * .03),

                                state is! forgetpassLoadingState
                                    ? Button(
                                      onpressed: () {
                                        LoginCubit.get(
                                          context,
                                        ).forgetpass(email: email);
                                      },
                                      text: ' اعادة ارسال الرمز ',
                                      color: Colors.white,
                                      textcolor: primary_blue,
                                    )
                                    : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                SizedBox(height: .02 * ScreenSize.height),
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

Widget OtpInput(context, TextEditingController inputdigitcontroller) {
  return SizedBox(
    width: 56,
    height: 56,
    child: TextFormField(
      cursorHeight: 3,
      textAlignVertical: TextAlignVertical.center,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '';
        }
        return null;
      },

      controller: inputdigitcontroller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
          borderSide: BorderSide(
            color: Color.fromRGBO(204, 204, 204, 1),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          // Border when not focused
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          // Border when focused
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
      },
      style: Theme.of(context).textTheme.labelMedium,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
      textAlign: TextAlign.center,
    ),
  );
}
