import 'package:damnhour_university/layout/layout.dart';
import 'package:damnhour_university/modules/reset-password/forget_password.dart';
import 'package:damnhour_university/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../shared/components/components.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/styles/colors.dart';

class ProtectionSafety extends StatelessWidget {
  const ProtectionSafety({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = UniversityCubit.get(context);
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextCairo(
                    text: 'الحماية والأمان',
                    color: Colors.black,
                    textalign: TextAlign.end,
                  ),
                  Column(
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'assets/images/undraw_forgot-password_odai 1.svg',
                          height: ScreenSize.height * 0.13,
                          width: ScreenSize.width * 0.33,
                        ),
                      ),
                      SizedBox(height: ScreenSize.height * 0.05), //40.0
                      TextCairo(
                        text:
                            'احمِ حسابك من الوصول غير المصرح به عن طريق تحديث كلمة المرور بشكل دوري.',
                        color: Colors.black,
                        fontsize: 14.0, //14.0
                        textalign: TextAlign.center,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      bottom: ScreenSize.height * 0.04,
                    ), //30.0
                    child: Button(
                      text: 'تغيير كلمة المرور',
                      onpressed: () {
                        navigatet_close(context: context, to: ForgetPassword());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
