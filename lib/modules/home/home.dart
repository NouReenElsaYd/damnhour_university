import 'package:damnhour_university/modules/complaints/complaintsform.dart';
import 'package:damnhour_university/modules/complaints/suggestionsform.dart';
import 'package:damnhour_university/shared/cubit/cubit.dart';
import 'package:damnhour_university/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../icons/custom_icons.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';
import '../../shared/styles/colors.dart';
import '../notifications/notifications.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController searchController = TextEditingController();

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
                    homeTextField('ارسال شكوي', context, () {
                      navigateTo(to: ComplaintsForm(), context: context);
                    }),
                    SizedBox(height: 10.0),
                    homeTextField('ارسال اقتراح', context, () {
                      navigateTo(to: SuggestionsForm(), context: context);
                    }),
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
              BlocConsumer<UniversityCubit, UniversityStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetAllComplaintsAndSuggestionsLoadingState) {
                    //print("Shimmer state is active");
                    return ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildShimmerPostItem(),
                      separatorBuilder:
                          (context, index) => SizedBox(height: 20),
                      itemCount: 5,
                    );
                  } else
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
                          ),
                        ),
                        Container(height: 1.0, color: brandColor25),

                        if (UniversityCubit.get(context).repliedPosts.isEmpty)
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
                        ).repliedPosts.isNotEmpty)
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder:
                                (context, index) => buildPostItem(
                                  context,
                                  UniversityCubit.get(
                                    context,
                                  ).repliedPosts[index],
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
                                ).repliedPosts.length,
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

  Widget homeTextField(
    String text,
    BuildContext context,
    VoidCallback function,
  ) => InkWell(
    child: Container(
      height: ScreenSize.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: primary_blue),
      ),
      child: Row(
        children: [
          Icon(CustomIcons.keyboard_arrow_left, color: primary_blue),
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
    ),
    onTap: function,
  );

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
}

String getTwoPartName(String? fullName) {
  final parts = fullName!.trim().split(' ');
  return '${parts[0]} ${parts[1]}';
}
