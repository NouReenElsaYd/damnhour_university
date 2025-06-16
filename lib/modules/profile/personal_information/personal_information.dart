import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../layout/layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/cubit/cubit.dart';
import '../../../shared/cubit/states.dart';
import '../../../shared/styles/colors.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UniversityCubit, UniversityStates>(
      listener: (context, state) {
        if (state is UpdateProfileInfoSuccessState) {
          showtoast(
            message: state.message,
            color: Colors.green,
          );
        }
      },
      builder: (context, state) {
        final cubit = UniversityCubit.get(context);
        return Scaffold(
          backgroundColor: primary_blue,
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.width * 0.05,
                  vertical: ScreenSize.height * 0.05,
                ),
                color: primary_blue,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          navigatet_close(to: LayoutScreen(), context: context);
                        },
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextCairo(
                            text: cubit.nameController.text,
                            fontweight: FontWeight.w400,
                            fontsize: 14.0,
                            color: Colors.white,
                          ),
                          TextCairo(
                            text: cubit.profilemodel!.faculty??'',
                            fontweight: FontWeight.w600,
                            fontsize: 14.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: ScreenSize.width * 0.03),
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Container(
                          width: ScreenSize.width * 0.2,
                          height: ScreenSize.width * 0.2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image:  cubit.profileImageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),

                        InkWell(
                          child: Container(
                            height: ScreenSize.width * 0.06,
                            width: ScreenSize.width * 0.06,
                            decoration: BoxDecoration(
                              color: accent_orange,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: ScreenSize.width * 0.04,
                            ),
                          ),
                          onTap: (){
                            cubit.updateProfileImage();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(ScreenSize.width * 0.05),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FlutterSwitch(
                                  value: cubit.isEnabled,
                                  onToggle: (value) {
                                    cubit.changeSwitch(value);
                                    if (!value) {
                                      cubit.updateProfileInfo(
                                        username: cubit.nameController.text,
                                        email: cubit.emailController.text,
                                        faculty: cubit.updateSelectedFaculty,
                                        phone: cubit.phoneController.text,
                                        adjective: cubit.statusController.text,
                                      );
                                    }
                                  },
                                  activeColor: Colors.blueAccent,
                                  height: ScreenSize.width * 0.06,
                                  width: ScreenSize.width * 0.12,
                                ),
                                SizedBox(width: ScreenSize.width * 0.02),
                                TextCairo(
                                  text: 'Edit',
                                  color: Colors.black,
                                  fontsize: 18.0,
                                  fontweight: FontWeight.w600,
                                ),
                              ],
                            ),
                            Expanded(
                              child: TextCairo(
                                text: 'معلومات المستخدم الشخصية',
                                fontweight: FontWeight.w600,
                                fontsize: 16.0,
                                color: Colors.black,
                                textalign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenSize.height * 0.02),
                        CustomTextFeild(
                          toptext: 'الاسم الكامل',
                          controller: cubit.nameController,
                          inputType: TextInputType.name,
                          enabled: cubit.isEnabled,
                        ),
                        CustomTextFeild(
                          toptext: 'البريد الإلكتروني',
                          controller: cubit.emailController,
                          inputType: TextInputType.emailAddress,
                          enabled: cubit.isEnabled,
                        ),
                        dropdownlist(
                         // bordercolor: cubit.facultyBorderColor,
                         // dropIcon: Icons.business_outlined,
                          hinttext: cubit.profilemodel?.faculty ??'',
                          enabled: cubit.isEnabled,
                          dropdownitems: [
                            'كلية الهندسة',
                            'كلية الحاسبات والمعلومات',
                            'كلية الفنون التطبيقية',
                            'كلية العلوم',
                            'كلية الصيدلة',
                            'كلية الطب البيطرى',
                            'كلية التربية',
                            'كلية الزراعة',
                            'كلية التجارة',
                            'كلية الحقوق',
                            'كلية الآداب',
                            'كلية التربية الطفولة المبكرة',
                            'كلية التربية النوعية',
                            'كلية التمريض',
                          ],
                         selectedvalue: cubit.updateSelectedFaculty,
                          onchanged: (newvalue) {
                            cubit.updateFaculty(newvalue!);
                          },
                          title: 'الكلية أو الإدارة',
                        ),
                        CustomTextFeild(
                          toptext: 'رقم الهاتف ',
                          controller: cubit.phoneController,
                          inputType: TextInputType.phone,
                          enabled: cubit.isEnabled,
                        ),
                        CustomTextFeild(
                          toptext: 'الصفة',
                          controller: cubit.statusController,
                          inputType: TextInputType.text,
                          enabled: cubit.isEnabled,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
