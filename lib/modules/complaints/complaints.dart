import 'package:damnhour_university/modules/complaints/complaintsform.dart';
import 'package:damnhour_university/modules/complaints/suggestionsform.dart';
import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/cubit/cubit.dart';
import 'package:damnhour_university/shared/cubit/states.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UniversityCubit, UniversityStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UniversityCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
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
                      SizedBox(height: ScreenSize.height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (cubit.filteredComplaints.isNotEmpty)
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
                                      child: TextCairo(
                                        text: 'اضافة',
                                        fontsize: 14.0,
                                      ),
                                    ),
                                    SizedBox(width: ScreenSize.width * 0.05),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                        end: ScreenSize.width * 0.025,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                cubit.resetpickedfile();
                                cubit.resetSelectedSector();
                                navigateTo(
                                  to: ComplaintsForm(),
                                  context: context,
                                );
                              },
                            ),
                          Expanded(
                            child: TextCairo(
                              text: 'أبرز الشكاوي والاقتراحات',
                              color: Colors.black,
                              fontsize: 18.0,
                              fontweight: FontWeight.w500,
                              textalign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ScreenSize.height * .015),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: ScreenSize.width * 0.04,
                    // bottom: ScreenSize.height * 0.02,
                  ),
                  child: sectorsListView(
                    onTap: (String sectorName) {
                      UniversityCubit.get(
                        context,
                      ).filterComplaintsBySector(sectorName);
                    },
                  ),
                ),
                if (cubit.activeComplaintsAndSuggestions.isEmpty)
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: ScreenSize.height * 0.1,
                    ),
                    child: Center(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            child: SvgPicture.asset(
                              "assets/images/complain.svg",
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextCairo(
                            text: '!لا توجد شكاوى حتى الآن',
                            color: Colors.black,
                            fontsize: 16,
                            fontweight: FontWeight.w500,
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 20,
                            ),
                            child: TextCairo(
                              text:
                                  'هل لديك أي ملاحظات أو اقتراحات؟ اضغط على الزر أدناه وشاركنا رأيك',
                              color: accent_orange,
                              fontsize: 14,
                              fontweight: FontWeight.w400,
                              textalign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 30),
                          Button(
                            onpressed: () {
                              UniversityCubit.get(
                                context,
                              ).resetSelectedSector();

                              navigateTo(
                                to: SuggestionsForm(),
                                context: context,
                              );
                            },
                            text: 'تقديم اقتراح',
                          ),
                          SizedBox(height: 16),
                          Button(
                            onpressed: () {
                              UniversityCubit.get(
                                context,
                              ).resetSelectedSector();
                              navigateTo(
                                to: ComplaintsForm(),
                                context: context,
                              );
                            },
                            text: 'تقديم شكوى',
                            color: Colors.white,
                            textcolor: primary_blue,
                          ),
                          SizedBox(height: ScreenSize.height * 0.1),
                        ],
                      ),
                    ),
                  ),
                if (cubit.activeComplaintsAndSuggestions.isNotEmpty)
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder:
                        (context, index) => buildPostItem(
                          context,
                          cubit.activeComplaintsAndSuggestions[index],
                        ),
                    separatorBuilder:
                        (context, index) => Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                            vertical: ScreenSize.height * 0.02,
                            horizontal: ScreenSize.width * 0.05,
                          ),
                          child: Container(height: 1, color: brandColor25),
                        ),
                    itemCount: cubit.activeComplaintsAndSuggestions.length,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
