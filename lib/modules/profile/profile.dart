import 'package:damnhour_university/modules/profile/personal_information/personal_information.dart';
import 'package:damnhour_university/modules/profile/protection_safety/protection_safety.dart';
import 'package:damnhour_university/modules/profile/questions/questions.dart';
import 'package:damnhour_university/modules/profile/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';
import '../../shared/styles/colors.dart';
import 'help_center/help_center.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary_blue,
      body: Column(
        children: [
          // الجزء الصورة والاسم
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

          // جزء ال container
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
                    TextCairo(
                      text: 'معلومات المستخدم الشخصية',
                      fontweight: FontWeight.w600,
                      fontsize: 16.0, // Fixed font size
                      color: Colors.black,
                    ),
                    SizedBox(height: ScreenSize.height * 0.02),
                    profileItem(
                      text: 'المعلومات الشخصية',
                      icon: Icons.person_2_outlined,
                      context: context,
                      widget: PersonalInformation(),
                    ),
                    SizedBox(height: ScreenSize.height * 0.02),
                    profileItem(
                      text: 'الحماية والأمان ',
                      icon: Icons.verified_user_outlined,
                      context: context,
                      widget: ProtectionSafety(),
                    ),
                    SizedBox(height: ScreenSize.height * 0.02),
                    profileItem(
                      text: 'الأسئلة الشائعة',
                      icon: Icons.help_outline,
                      context: context,
                      widget: Questions(),
                    ),
                    SizedBox(height: ScreenSize.height * 0.02),
                    profileItem(
                      text: 'مركز المساعدة',
                      context: context,
                      widget: HelpCenter(),
                    ),
                    SizedBox(height: ScreenSize.height * 0.02),
                    profileItem(
                      text: 'الإعدادات',
                      icon: Icons.settings,
                      context: context,
                      widget: Settings(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget profileItem({
  required String text,
  IconData? icon,
  String? image,
  required context,
  required Widget widget,
}) => Container(
  padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.03),
  child: Row(
    children: [
      IconButton(
        onPressed: () {
          navigateTo(to: widget, context: context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          size: ScreenSize.width * 0.04,
          color: brandColor200,
        ),
      ),
      SizedBox(width: ScreenSize.width * 0.025),
      Expanded(
        child: TextCairo(
          text: text,
          fontweight: FontWeight.w600,
          fontsize: 14.0,
          color: brand,
          textalign: TextAlign.end,
        ),
      ),
      SizedBox(width: ScreenSize.width * 0.025),
      if (icon == null)
        SvgPicture.asset(
          'assets/images/help.svg',
          height: ScreenSize.width * 0.05,
          width: ScreenSize.width * 0.05,
          colorFilter: ColorFilter.mode(primary_blue, BlendMode.srcIn),
        )
      else
        Icon(icon, color: primary_blue, size: ScreenSize.width * 0.06),
    ],
  ),
);
