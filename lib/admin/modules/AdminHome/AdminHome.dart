// ignore_for_file: must_be_immutable
import 'package:damnhour_university/admin/modules/AdminNotification/AdminNotification.dart';
import 'package:damnhour_university/icons/custom_icons.dart';
import 'package:damnhour_university/models/home_model.dart';
import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/cubit/cubit.dart';
import 'package:damnhour_university/shared/cubit/states.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class AdminHome extends StatelessWidget {
  AdminHome({super.key});

  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        displacement: 10.0,
        color: Colors.white,
        backgroundColor: accent_orange,
        onRefresh: () async {
          UniversityCubit.get(context).getComplaintsAndSuggestions();
        },
        child: SingleChildScrollView(
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
                                to: AdminNotification(),
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
                          onChanged: (value) {
                            print(
                              UniversityCubit.get(
                                context,
                              ).filteredPosts.length,
                            );
                            UniversityCubit.get(context).updateSearchId(value);
                          },
                          controller: searchcontroller,
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
              BlocConsumer<UniversityCubit, UniversityStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetAllComplaintsAndSuggestionsLoadingState)
                    return ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildShimmerPostItem(),
                      separatorBuilder:
                          (context, index) => SizedBox(height: 20),
                      itemCount: 5,
                    );
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          end: ScreenSize.width * 0.04,
                          bottom: ScreenSize.height * 0.02,
                        ),
                        child: sectorsListView(
                          onTap: (String sectorName) {
                            UniversityCubit.get(
                              context,
                            ).filterPostsBySector(sectorName);
                          },
                        ), ///////////
                      ),
                      Container(height: 1.0, color: brandColor25),
                      if (UniversityCubit.get(
                        context,
                      ).filteredPosts.isEmpty)  //filteredPostsbystatus
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            top: ScreenSize.height * 0.02,
                          ),
                          child: Center(
                            child: TextCairo(
                              text: ' لا يوجد شكاوي او اقتراحات حتي الان',
                              color: accent_orange,
                            ),
                          ),
                        ),
                      if (UniversityCubit.get(
                        context,
                      ).filteredPosts.isNotEmpty)
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder:
                              (context, index) => buildPostItem(
                                context,
                                UniversityCubit.get(
                                  context,
                                ).filteredPosts[index],
                                UniversityCubit.get(context),
                              ),
                          separatorBuilder:
                              (context, index) => Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                  vertical: ScreenSize.height * 0.02,
                                ),
                                child: Container(
                                  height: 1,
                                  color: brandColor25,
                                ),
                              ),
                          itemCount:
                              UniversityCubit.get(
                                context,
                              ).filteredPosts.length,
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////BUILD POST ITEM/////////////////////////////////////////////////////////

  Widget homeTextField(String text, BuildContext context, VoidCallback onTap) =>
      Container(
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

  Widget buildPostItem(context, ItemModel model, UniversityCubit cubit) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: ScreenSize.width * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: statusof(
                        text: model.status ?? '',
                        color:
                            model.status == "معلق"
                                ? Colors.amberAccent
                                : model.status == "قيد التنفيذ"
                                ? brandColor200
                                : model.status == "مرفوض"
                                ? Colors.red
                                : Colors.green,
                      ),
                    ),
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
                              text: getTwoPartName(model.user?.username),
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
                  // navigateTo(to: AdminProfile(), context: context);
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://th.bing.com/th/id/OIP.peFzV1_5MyCO7JjmohnBUQHaHa?w=500&h=500&rs=1&pid=ImgDetMain',
                  ),
                  radius: 25.0,
                ),
              ),
            ],
          ),
          if (model.attachments != null)
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 10.0),
              child:
                  cubit.getFileType(model.attachments) == 'Image'
                      ? Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(model.attachments ?? ''),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                      : Container(
                        height: 150,
                        width: double.infinity,
                        child: SvgPicture.asset('assets/images/pdf.svg'),
                      ),
            ),
          if (model.attachments == null) SizedBox(height: 20),
          SizedBox(height: .01 * ScreenSize.height),
          TextCairo(
            text: ' ${model.title}',
            color: Colors.black,
            fontweight: FontWeight.w600,
          ),
          SizedBox(height: .01 * ScreenSize.height),
          TextCairo(
            textalign: TextAlign.right,
            text: model.description ?? '',
            fontweight: FontWeight.w400,
            fontsize: 14.0,
            color: Colors.black,
          ),
          if (model.attachments == null) SizedBox(height: 20),
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
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: ScreenSize.width * 0.02),
                      TextCairo(
                        text: '${model.dislike_count}',
                        color: Colors.black,
                      ),
                      Container(
                        width: ScreenSize.width * 0.15,
                        height: ScreenSize.height * 0.045,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.thumb_down_alt_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: ScreenSize.width * 0.02),
                      TextCairo(
                        text: '${model.like_count}',
                        color: Colors.black,
                      ),
                      Container(
                        width: ScreenSize.width * 0.15,
                        height: ScreenSize.height * 0.045,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.black,
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

Widget buildShimmerPostItem() {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: ScreenSize.width * 0.04,
      vertical: ScreenSize.height * 0.01,
    ),
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: ScreenSize.width * 0.25,
                      height: ScreenSize.height * 0.04,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: ScreenSize.width * 0.22,
                              height: ScreenSize.height * 0.018,
                              color: Colors.white,
                            ),
                            SizedBox(width: ScreenSize.width * 0.02),
                            Container(
                              width: ScreenSize.width * 0.22,
                              height: ScreenSize.height * 0.018,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenSize.height * 0.008),
                        Container(
                          width: ScreenSize.width * 0.15,
                          height: ScreenSize.height * 0.013,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: ScreenSize.width * 0.04),
              Container(
                width: ScreenSize.width * 0.13,
                height: ScreenSize.width * 0.13,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenSize.height * 0.012),
          Container(
            height: ScreenSize.height * 0.18,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.012),
          Container(
            width: double.infinity,
            height: ScreenSize.height * 0.018,
            color: Colors.white,
          ),
          SizedBox(height: ScreenSize.height * 0.008),
          Container(
            width: ScreenSize.width * 0.7,
            height: ScreenSize.height * 0.018,
            color: Colors.white,
          ),
          SizedBox(height: ScreenSize.height * 0.012),
          Container(
            height: ScreenSize.height * 0.07,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

String getTwoPartName(String? fullName) {
  final parts = fullName!.trim().split(' ');
  return '${parts[0]} ${parts[1]}';
}
