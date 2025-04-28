import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../shared/components/components.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/cubit/cubit.dart';
import '../../../shared/cubit/states.dart';
import '../../../shared/styles/colors.dart';

// ignore: must_be_immutable
class PersonalInformation extends StatelessWidget {
  PersonalInformation({super.key});
  TextEditingController nameController = TextEditingController(
    text: 'محمد طلعت بسيوني',
  );
  TextEditingController emailController = TextEditingController(
    text: 'mohamedbasiouny@gmail.com',
  );
  TextEditingController universityController = TextEditingController(
    text: 'كلية الحاسبات والمعلومات',
  );
  TextEditingController phoneController = TextEditingController(
    text: '01111111111',
  );
  TextEditingController statusController = TextEditingController(text: 'طالب');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UniversityCubit, UniversityStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var cubit = UniversityCubit.get(context);
        return Scaffold(
          backgroundColor: primary_blue,
          body: Column(
            children: [
              // جزء الصورة والاسم
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextCairo(
                            text: 'محمد طلعت بسيوني',
                            fontweight: FontWeight.w400,
                            fontsize: 14.0, // Fixed font size
                            color: Colors.white,
                          ),
                          TextCairo(
                            text: 'كلية الحاسبات والمعلومات',
                            fontweight: FontWeight.w600,
                            fontsize: 14.0, // Fixed font size
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: ScreenSize.width * 0.03),
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          radius: ScreenSize.width * 0.1,
                          backgroundImage: const NetworkImage(
                            'https://s3-alpha-sig.figma.com/img/f6e0/670a/b2cb85130e4a021a8db54043dfdd2a59?Expires=1745193600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=ZQMTCmbrD3N7ICohN6u8I~m7mf93LAkyXW4n5F7Bm8ZP5NsZmX4k4xB5Lfhl6EnvumRVmub7rUv-yyfTyHrDDP-KM92Vt4XZUw5WM7vIlRWjGkaG1GglabEVTFY8~yZ-ky5j03iZzRseaztBsJHJIj-AYEgnTXgk-1uXUuGsJYFKqGv~CsBXm-hW6skkrkWd5rD056aefHg3UN96ptJ64hchHsBs5Y~~JDHoG5oMVIDXMdEa3uXgx65DFb~m7b-Pt2WdcRi1MTSkDqFXbViOiI-S3tKkB72maCRW1ceMPbeR5bmHo1yR51KRccQmC1Xce2pUC~WHv8uzzm7W6RVY7g__',
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
                                  value: UniversityCubit.get(context).isEnabled,
                                  onToggle: (value) {
                                    UniversityCubit.get(
                                      context,
                                    ).changeSwitch(value);
                                  },
                                  activeColor: Colors.blueAccent,
                                  height: ScreenSize.width * 0.06,
                                  width: ScreenSize.width * 0.12,
                                ),
                                SizedBox(width: ScreenSize.width * 0.02),
                                TextCairo(
                                  text: 'Edit',
                                  color: Colors.black,
                                  fontsize: 18.0, // Fixed font size
                                  fontweight: FontWeight.w600,
                                ),
                              ],
                            ),
                            Expanded(
                              child: TextCairo(
                                text: 'معلومات المستخدم الشخصية',
                                fontweight: FontWeight.w600,
                                fontsize: 16.0, // Fixed font size
                                color: Colors.black,
                                textalign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenSize.height * 0.02),
                        CustomTextFeild(
                          toptext: 'الاسم الكامل',
                          controller: nameController,
                          inputType: TextInputType.name,
                          enabled: cubit.isEnabled,
                        ),
                        CustomTextFeild(
                          toptext: 'البريد الإلكتروني',
                          controller: emailController,
                          inputType: TextInputType.emailAddress,
                          enabled: cubit.isEnabled,
                        ),
                        CustomTextFeild(
                          toptext: 'الكلية أو الإدارة',
                          controller: universityController,
                          inputType: TextInputType.text,
                          enabled: cubit.isEnabled,
                        ),
                        CustomTextFeild(
                          toptext: 'رقم الهاتف ',
                          controller: phoneController,
                          inputType: TextInputType.phone,
                          enabled: cubit.isEnabled,
                        ),
                        CustomTextFeild(
                          toptext: 'الصفة',
                          controller: statusController,
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
