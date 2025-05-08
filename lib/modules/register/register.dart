// ignore_for_file: unnecessary_null_comparison

import 'package:damnhour_university/icons/custom_icons.dart';
import 'package:damnhour_university/modules/login/login.dart';
import 'package:damnhour_university/modules/register/cubit/register_cubit.dart';
import 'package:damnhour_university/modules/register/cubit/register_states.dart';
import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  Register({super.key});
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController idcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is registerSuccessState) {
            Fluttertoast.showToast(
              msg: 'تم التسجيل بنجاح',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16,
            );
            navigateTo(to: Login(), context: context);
            print("register success");
          } else if (state is registerErrorState) {
            Fluttertoast.showToast(
              msg: 'خطأ حاول لاحقا',
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
          var cubit = RegisterCubit.get(context);
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
                                  key: _formkey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomTextFeild(
                                        bordercolor: cubit.namecolor,
                                        Validator: (value) {
                                          cubit.validateName(value ?? '');
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'الاسم مطلوب';
                                          }
                                          final parts = value.trim().split(
                                            RegExp(r'\s+'),
                                          );
                                          if (parts.length < 3) {
                                            return 'يرجى كتابة الاسم الثلاثي على الأقل';
                                          }
                                          return null;
                                        },
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
                                        bordercolor: cubit.emailcolor,
                                        Validator: (value) {
                                          cubit.validateEmail(value ?? '');
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'البريد الإلكتروني مطلوب';
                                          }
                                          if (!RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                          ).hasMatch(value)) {
                                            return 'صيغة البريد الإلكتروني غير صحيحة';
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
                                      SizedBox(height: ScreenSize.height * .01),
                                      CustomTextFeild(
                                        inputType: TextInputType.number,
                                        bordercolor: cubit.idcolor,
                                        Validator: (value) {
                                          cubit.validateNationalId(value ?? '');
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'الرقم القومي مطلوب';
                                          }
                                          if (!RegExp(
                                            r'^\d{14}$',
                                          ).hasMatch(value)) {
                                            return 'يجب أن يتكون الرقم القومي من 14 رقمًا';
                                          }
                                          return null;
                                        },
                                        keyboardtype: TextInputType.number,
                                        controller: idcontroller,
                                        hinttext: ' الرقم القومي',
                                        prefixicon: Icon(
                                          CustomIcons.vcard,
                                          color: primary_blue,
                                        ),
                                        toptext: 'الرقم القومي',
                                      ),
                                      CustomTextFeild(
                                        bordercolor: cubit.phonecolor,
                                        Validator: (value) {
                                          cubit.validatePhoneNumber(
                                            value ?? '',
                                          );
                                          if (value?.isEmpty ?? true)
                                            return 'رقم الهاتف مطلوب';
                                          if (value!.length != 11 ||
                                              !RegExp(
                                                r'^\d+$',
                                              ).hasMatch(value)) {
                                            return 'يجب أن يتكون رقم الهاتف من 11 رقمًا';
                                          }
                                          return null;
                                        },

                                        controller: phonecontroller,
                                        keyboardtype: TextInputType.phone,
                                        hinttext: 'ادخل رقم الهاتف',
                                        prefixicon: Icon(
                                          Icons.phone,
                                          color: primary_blue,
                                        ),
                                        toptext: 'رقم الهاتف',
                                      ),

                                      dropdownlist(
                                        bordercolor: cubit.adjectiveborder,
                                        dropIcon: Icons.people_outline,
                                        hinttext: "اختر الصفه",
                                        dropdownitems: [
                                          'student',
                                          'موظف',
                                          'خرَّيج',
                                        ],
                                        selectedvalue: cubit.selectedadjective,
                                        onchanged: (newvalue) {
                                          cubit.changeSelectedadjective(
                                            newvalue,
                                          );
                                        },
                                        title: 'اختر الصفه',
                                      ),
                                      dropdownlist(
                                        bordercolor: cubit.facultyBorderColor,
                                        dropIcon: Icons.business_outlined,
                                        hinttext: "اختر الكليه",
                                        dropdownitems: [
                                          'هندسه',
                                          'حاسبات و معلومات',
                                          'كلية تجاره',
                                          'كلية الاقتصاد و العلوم السياسيه',
                                          'فنون جميله',
                                        ],
                                        selectedvalue: cubit.selectedfaculty,
                                        onchanged: (newvalue) {
                                          cubit.changeSelectedfaculty(newvalue);
                                        },
                                        title: 'اختر الكليه',
                                      ),

                                      SizedBox(height: ScreenSize.height * .01),
                                      CustomTextFeild(
                                        bordercolor: cubit.passwordcolor,
                                        Validator: (value) {
                                          cubit.validatePassword(value ?? '');
                                          if (value?.isEmpty ?? true)
                                            return 'كلمة المرور مطلوبة';
                                          if (value!.length < 8)
                                            return 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';
                                          if (!RegExp(
                                            r'^(?=.*[A-Za-z])(?=.*\d)',
                                          ).hasMatch(value)) {
                                            return 'يجب أن تحتوي على حروف وأرقام';
                                          }
                                          return null;
                                        },
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
                                      ),

                                      SizedBox(height: ScreenSize.height * .01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                state is! registerLoadState
                                    ? Button(
                                      onpressed: () {
                                        cubit.validateFaculty();
                                        cubit.validateadjective();
                                        if (_formkey.currentState!.validate()) {
                                          cubit.Register_user(
                                            username: namecontroller.text,
                                            email: emailcontroller.text,
                                            password: passwordcontroller.text,
                                            agree_terms: true,
                                            adjective: cubit.selectedadjective!,
                                            faculty: cubit.selectedfaculty!,
                                            national_id: idcontroller.text,
                                            phone: phonecontroller.text,
                                          );
                                        }
                                      },
                                      text: ' تسجيل ',
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
        },
      ),
    );
  }
}
