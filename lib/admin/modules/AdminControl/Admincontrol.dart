// ignore_for_file: must_be_immutable

import 'package:damnhour_university/admin/modules/AdminControl/AdminReply.dart';
import 'package:damnhour_university/admin/modules/AdminNotifications/AdminNotifications.dart';
import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class AdminControl extends StatelessWidget {
  AdminControl({super.key});
  TextEditingController searchcontroller = TextEditingController();
  String? selectedvalue;
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
                            navigateTo(
                              to: AdminNotifications(),
                              context: context,
                            );
                          },
                          icon: Icon(
                            Icons.notifications_none,
                            color: primary_blue,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextCairo(
                              text: 'جامعة دمنهور',
                              color: accent_orange,
                              fontweight: FontWeight.w400,
                              fontsize: 13.0,
                            ),
                            TextCairo(
                              text: 'صفحة التحكم',
                              color: Colors.black,
                              fontweight: FontWeight.w500,
                              fontsize: 16.0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15.0),
                      Container(
                        height: 52,
                        child: Image(
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  TextCairo(
                    text: ' الشكاوي والاقتراحات',
                    color: Colors.black,
                    fontsize: 18.0,
                    fontweight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * 0.06,
              ),
              child: Row(
                children: [
                  // Dropdown
                  dropdownlist(
                    dropdownitems: ['معلق', 'قيد التنفيذ', 'تم الحل', 'مرفوض'],
                    hinttext: '',
                    bordercolor: brandColor200,
                    onchanged: (value) {},
                    width: 104,
                    selectedvalue: selectedvalue,
                  ),
                  SizedBox(width: 8),
                  // Search field
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: brandColor200),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Icon(Icons.search, color: accentColor100),
                          ),
                          Expanded(
                            child: TextField(
                              controller: searchcontroller,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "بحث",
                                hintStyle: TextStyle(
                                  color: accentColor100,
                                  fontFamily: 'Cairo',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
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
                    // child: Container(height: 1, color: brandColor25),
                  ),
              itemCount: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPostItem(context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.02),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsetsDirectional.symmetric(
        vertical: ScreenSize.height * 0.02,
        horizontal: ScreenSize.width * 0.04,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                            SizedBox(width: 8.0),
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
              SizedBox(width: 15.0),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://s3-alpha-sig.figma.com/img/fc8e/8722/3d89c4f6964dd191b6eccf24c31b6620?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Ashj48mbbmqvoaNVPGCuGRu~kQWQuszCOTY7xhCo4hb6-keMI-yTX~~uYMkM2HCiVaP~pYY1855rEyS6RXEt3ejJKlopYSCgBknkdNlhodHmio2KSFOqFQQEKUa4RGlw2~x3DyLPQa8FFytHLhIXi-mT-f0vhvmBfTlgDOVp7gLHHqYaL-l5aaCMakOdxpVmmwloPs-NMml9Jn6B7D4NcTszXMQuZ2x9CaqMppjlM9cf92vV518-rZjQ7H1XmDitfHVNKbHxDBG60VllCh0XsO-tksr3jiLND4UOKYq8btuPXbyBB7RYh4wsAn79rCKMWjczid7sffoNKzLkK8mn1g__',
                    ),
                    radius: 25.0,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 10.0),
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
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
          SizedBox(height: 10.0),
          Button(
            text: 'فتح',
            onpressed: () {
              navigateTo(to: AdminReply(), context: context);
            },
          ),
        ],
      ),
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
    padding: EdgeInsets.symmetric(horizontal: 8),
    width: 100,
    height: 34,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
