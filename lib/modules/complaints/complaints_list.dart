// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../icons/custom_icons.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';
import '../../shared/styles/colors.dart';
import '../notifications/notifications.dart';
import '../profile/profile.dart';

class ComplaintsListScreen extends StatelessWidget {
  ComplaintsListScreen({super.key});
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                top: ScreenSize.height * 0.055,
                start: ScreenSize.width * 0.04,
                end: ScreenSize.width * 0.04,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: accentColor50,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            navigateTo(to: Notifications(), context: context);
                          },
                          icon: Icon(
                            Icons.notifications_none,
                            color: primary_blue,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextCairo(
                              text: 'جامعة دمنهور',
                              color: accent_orange,
                              fontweight: FontWeight.w400,
                              fontsize: 13.0,
                            ),
                            TextCairo(
                              text: 'الشكاوي والمقترحات',
                              color: Colors.black,
                              fontweight: FontWeight.w500,
                              fontsize: 16.0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: ScreenSize.width * 0.04),
                      Container(
                        height: ScreenSize.height * 0.07,
                        child: Image(
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.025),
            Padding(
              padding: EdgeInsetsDirectional.only(
                end: ScreenSize.width * 0.04,
                bottom: ScreenSize.height * 0.02,
              ),
              child: sectorsListView(),
            ),
            Padding(
              //جزئيه ال الشكاوي + Buttom
              padding: EdgeInsetsDirectional.only(
                start: ScreenSize.width * 0.04,
                end: ScreenSize.width * 0.04,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: primary_blue,
                        borderRadius: BorderRadius.circular(
                          ScreenSize.width * 0.05,
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: ScreenSize.width * 0.1,
                              top: ScreenSize.height * 0.015,
                              bottom: ScreenSize.height * 0.015,
                            ),
                            child: TextCairo(text: 'اضافة', fontsize: 14.0),
                          ),
                          SizedBox(width: ScreenSize.width * 0.05),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              end: ScreenSize.width * 0.025,
                            ),
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // navigateTo(to: ComplaintsForm(), context: context);
                    },
                  ),
                  TextCairo(
                    text: 'الشكاوي والمقترحات',
                    color: Colors.black,
                    fontsize: 18.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                vertical: ScreenSize.height * 0.02,
              ),
              child: Container(height: 1, color: brandColor25),
            ),
            Padding(
              //جزئيه ال textField + dropDownList
              padding: EdgeInsetsDirectional.only(
                start: ScreenSize.width * 0.04,
                end: ScreenSize.width * 0.04,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: dropdownlist(
                      selectedvalue: 'الكل',
                      title: 'null',
                      hinttext: 'الكل',
                      dropdownitems: [
                        'الكل',
                        'قطاع شئون التعليم',
                        'قطاع إدارة الجامعة',
                        'قطاع الدراسات العليا',
                        'قطاع أمين عام الجامعة',
                        'قطاع خدمة المجتمع',
                      ],
                      onchanged: (value) {},
                      dropIcon: Icons.keyboard_arrow_down_outlined,
                      bordercolor: brandColor25,
                    ),
                  ),
                  SizedBox(width: ScreenSize.width * 0.025),
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: ScreenSize.height * 0.055,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          ScreenSize.width * 0.02,
                        ),
                        border: Border.all(color: brandColor25),
                      ),
                      child: TextField(
                        controller: searchController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'بحث',
                          hintStyle: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14,
                            color: brandColor25,
                          ),
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search, color: brandColor25),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.02),
            Container(height: 1.0, color: brandColor25),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => buildPostItem(context),
              separatorBuilder:
                  (context, index) => Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical: ScreenSize.height * 0.02,
                    ),
                    child: Container(height: 1, color: brandColor25),
                  ),
              itemCount: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget homeTextField(String text) => Container(
    height: ScreenSize.height * 0.06,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(ScreenSize.width * 0.02),
      border: Border.all(color: primary_blue),
    ),
    child: Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(CustomIcons.keyboard_arrow_left, color: primary_blue),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: ScreenSize.width * 0.05),
              child: TextCairo(
                text: text,
                color: Colors.black,
                fontweight: FontWeight.w500,
                fontsize: 16.0,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildPostItem(context) => Padding(
    padding: EdgeInsetsDirectional.symmetric(
      horizontal: ScreenSize.width * 0.04,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  statusof(text: 'قيد التنفيذ', color: brandColor200),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextCairo(
                            text: 'منذ 2 س',
                            color: brand,
                            fontsize: 14.0,
                            fontweight: FontWeight.w400,
                          ),
                          SizedBox(width: ScreenSize.width * 0.02),
                          TextCairo(
                            text: 'محمد طلعت',
                            color: primary_blue,
                            fontsize: 14.0,
                            fontweight: FontWeight.w400,
                          ),
                        ],
                      ),
                      TextCairo(
                        text: 'كلية الحاسبات والمعلومات',
                        color: accent_orange,
                        fontsize: 10.0,
                        fontweight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: ScreenSize.width * 0.04),
            InkWell(
              onTap: () {
                navigateTo(to: ProfileScreen(), context: context);
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://s3-alpha-sig.figma.com/img/fc8e/8722/3d89c4f6964dd191b6eccf24c31b6620?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Ashj48mbbmqvoaNVPGCuGRu~kQWQuszCOTY7xhCo4hb6-keMI-yTX~~uYMkM2HCiVaP~pYY1855rEyS6RXEt3ejJKlopYSCgBknkdNlhodHmio2KSFOqFQQEKUa4RGlw2~x3DyLPQa8FFytHLhIXi-mT-f0vhvmBfTlgDOVp7gLHHqYaL-l5aaCMakOdxpVmmwloPs-NMml9Jn6B7D4NcTszXMQuZ2x9CaqMppjlM9cf92vV518-rZjQ7H1XmDitfHVNKbHxDBG60VllCh0XsO-tksr3jiLND4UOKYq8btuPXbyBB7RYh4wsAn79rCKMWjczid7sffoNKzLkK8mn1g__',
                ),
                radius: ScreenSize.width * 0.06,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsetsDirectional.symmetric(
            vertical: ScreenSize.height * 0.015,
          ),
          child: Container(
            height: ScreenSize.height * 0.2,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenSize.width * 0.02),
              image: DecorationImage(
                image: NetworkImage(
                  'https://s3-alpha-sig.figma.com/img/fdc1/8583/d1cf5c8e5fbb4b0dd6ef382341266755?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=YgMc7pFWvu2HrJbnW~KPr36bhrUfjnnISJXfrtVLKMLWb15q1CcKu2LSDy~wPm1z8PWT4hmFAzsiR9-RhrZiP80Q9MghGFULew862bAr4QqRsAgL9LpnTFygNbyI116CJl54O986Ccv7I8UfWcNUGJA3LCskQenxAw2bZ1kJ-l9Lj5atLZ2bhDSfCOxPML0u5QaLqoFitxH-GcZDmBsKapAEHEthQt~jB~ekwLUmAzo4NhQC5TRPRGROxUHZ08bd-IJHhjldReJbO3fe7Zwmm4D2SO6vpFrTLOBSelZHR7sqrm0roSQZ81odt~oXT2~RqCmHaV5aX1364t4qAvPMCg__',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        TextCairo(
          textalign: TextAlign.right,
          text:
              'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها',
          fontweight: FontWeight.w400,
          fontsize: 11.0,
          color: Colors.black,
        ),
        SizedBox(height: ScreenSize.height * 0.015),
        Container(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: ScreenSize.width * 0.05,
          ),
          width: double.infinity,
          height: ScreenSize.height * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenSize.width * 0.02),
            border: Border.all(color: neutralColor25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: ScreenSize.width * 0.15,
                      height: ScreenSize.height * 0.045,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          ScreenSize.width * 0.02,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.thumb_down_alt_outlined),
                      ),
                    ),
                    SizedBox(width: ScreenSize.width * 0.02),
                    Container(
                      width: ScreenSize.width * 0.15,
                      height: ScreenSize.height * 0.045,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          ScreenSize.width * 0.02,
                        ),
                        color: brandColor25,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.thumb_up_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  end: ScreenSize.width * 0.05,
                ),
                child: TextCairo(
                  text: 'هل هذه الشكوى حقيقية ؟',
                  fontsize: 13.0,
                  fontweight: FontWeight.w400,
                  color: primary_blue,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget statusof({
    required String text,
    required Color color,
    IconData? icon = Icons.folder_outlined,
  }) => Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 1, child: Icon(icon, color: Colors.white)),
        Expanded(
          flex: 2,
          child: TextCairo(
            text: text,
            fontsize: 12,
            fontweight: FontWeight.bold,
            textalign: TextAlign.right,
          ),
        ),
      ],
    ),
    padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.02),
    width: ScreenSize.width * 0.25,
    height: ScreenSize.height * 0.045,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(ScreenSize.width * 0.02),
    ),
  );
}
