import 'package:damnhour_university/models/home_model.dart';
import 'package:damnhour_university/modules/complaints/complaintsform.dart';
import 'package:damnhour_university/modules/complaints/suggestionsform.dart';
import 'package:damnhour_university/modules/records/records.dart';
import 'package:damnhour_university/shared/cubit/cubit.dart';
import 'package:damnhour_university/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../icons/custom_icons.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';
import '../../shared/styles/colors.dart';
import '../notifications/notifications.dart';
import '../profile/profile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UniversityCubit, UniversityStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (UniversityCubit.get(context).feedBackModel == null) {
          return Center(child: CircularProgressIndicator());
        }
        else
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
                                  to: Notifications(),
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
                                padding: EdgeInsetsDirectional.only(
                                  start: 10.0,
                                ),
                                child: Icon(
                                  Icons.search,
                                  color: accentColor100,
                                ),
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
                      homeTextField('ارسال شكوي',context,(){navigateTo(to: ComplaintsForm(), context: context);}),
                      SizedBox(height: 10.0),
                      homeTextField('ارسال اقتراح',context,(){navigateTo(to: SuggestionsForm(), context: context);}),
                      SizedBox(height: 10.0),
                      homeTextField(
                        'متابعة الطلبات',
                        context,
                            () => UniversityCubit.get(context).changeBottomNav(1),
                      ),
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
                  itemBuilder:
                      (context, index) => buildPostItem(
                        context,
                        UniversityCubit.get(context).feedBackModel!.data[index],
                      ),
                  separatorBuilder:
                      (context, index) => Padding(
                        padding: EdgeInsetsDirectional.symmetric(
                          vertical: ScreenSize.height * 0.02,
                        ),
                        child: Container(height: 1, color: brandColor25),
                      ),
                  itemCount: UniversityCubit.get(context).feedBackModel!.data.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget homeTextField(String text, BuildContext context, VoidCallback onTap) => Container(
    height: ScreenSize.height * 0.06,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: primary_blue),
    ),
    child: Row(
      children: [
        IconButton(
          onPressed: onTap,
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


  Widget buildPostItem(context, ItemModel model) => Padding(
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
              //flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(child: statusof(text: 'قيد الدراسة', color: brandColor200)),
                  //Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextCairo(
                            color: brand,
                            text: model.created_at ?? '',
                            fontsize: 14.0,
                            fontweight: FontWeight.w400,
                          ),
                          SizedBox(width: 8.0),
                          TextCairo(
                            text: model.user?.username ?? '',
                            color: primary_blue,
                            fontsize: 14.0,
                            fontweight: FontWeight.w400,
                          ),
                        ],
                      ),
                      TextCairo(
                        text: model.user?.faculty ?? '',
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
        if (model.attachments != null)
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 10.0),
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(
                    model.attachments ?? 'null',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        TextCairo(
          textalign: TextAlign.right,
          text: model.description ?? '',
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
  /////////////////////////////////////////////////STATUS OF COMPLAINTS///////////////////////////////////////////////////
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

//