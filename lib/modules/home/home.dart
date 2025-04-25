import 'package:flutter/material.dart';

import '../../icons/custom_icons.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';
import '../../shared/styles/colors.dart';
import '../profile/profile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController searchController = TextEditingController();

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
                          onPressed: () {},
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
                              text: 'الشكاوي والمقترحات',
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
                  SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: accent_orange),
                      //color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 20.0,
                        top: 6.0,
                      ),
                      child: TextField(
                        controller: searchController,
                        textAlign: TextAlign.right, // Arabic text
                        decoration: InputDecoration(
                          hintText: "ما الذي تبحث عنه؟",
                          hintStyle: TextStyle(
                            color: accentColor100,
                            fontFamily: 'Cairo',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: EdgeInsetsDirectional.only(start: 10.0),
                            child: Icon(Icons.search, color: accentColor100),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  TextCairo(
                    text: 'كيف يمكننا مساعدتك اليوم ؟',
                    fontweight: FontWeight.w500,
                    fontsize: 18.0,
                    color: Colors.black,
                  ),
                  SizedBox(height: 10.0),
                  homeTextField('ارسال شكوي'),
                  SizedBox(height: 10.0),
                  homeTextField('ارسال اقتراح'),
                  SizedBox(height: 10.0),
                  homeTextField('متابعة الطلبات'),
                  SizedBox(height: 20.0),
                  TextCairo(
                    text: 'أبرز الشكاوي والاقتراحات',
                    color: Colors.black,
                    fontsize: 18.0,
                    fontweight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsetsDirectional.only(
                end: ScreenSize.width * 0.04,
                bottom: ScreenSize.height * 0.02,
              ),
              child: sectorsListView(),
            ),
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
    // width: 327 / 375 * ScreenSize.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: primary_blue),
      //color: Colors.white,
    ),
    child: Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(CustomIcons.keyboard_arrow_left, color: primary_blue),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 20.0),
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
      // vertical: ScreenSize.height* 0.02,
      horizontal: ScreenSize.width * 0.04,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
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
            ),
            SizedBox(width: 15.0),
            InkWell(
              onTap: () {
                navigateTo(to: ProfileScreen(), context: context);
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://s3-alpha-sig.figma.com/img/fc8e/8722/3d89c4f6964dd191b6eccf24c31b6620?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Ashj48mbbmqvoaNVPGCuGRu~kQWQuszCOTY7xhCo4hb6-keMI-yTX~~uYMkM2HCiVaP~pYY1855rEyS6RXEt3ejJKlopYSCgBknkdNlhodHmio2KSFOqFQQEKUa4RGlw2~x3DyLPQa8FFytHLhIXi-mT-f0vhvmBfTlgDOVp7gLHHqYaL-l5aaCMakOdxpVmmwloPs-NMml9Jn6B7D4NcTszXMQuZ2x9CaqMppjlM9cf92vV518-rZjQ7H1XmDitfHVNKbHxDBG60VllCh0XsO-tksr3jiLND4UOKYq8btuPXbyBB7RYh4wsAn79rCKMWjczid7sffoNKzLkK8mn1g__',
                ),
                radius: 25.0,
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
        Container(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: ScreenSize.width * 0.05,
          ),
          width: double.infinity,
          height: ScreenSize.height * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: neutralColor25),
            //color: Colors.white,
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
                      //color: brandColor25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        // color:  brandColor25,
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
                      //color: brandColor25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        //border: Border.all(color:brandColor25),
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
}
