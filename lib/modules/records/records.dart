import 'package:damnhour_university/modules/complaints/complaintsform.dart';
import 'package:damnhour_university/modules/complaints/suggestionsform.dart';
import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class RecordsScreen extends StatelessWidget {
  const RecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = UniversityCubit.get(context);
    return BlocConsumer<UniversityCubit, UniversityStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                      TextCairo(
                        text: 'أبرز الشكاوي والاقتراحات',
                        color: Colors.black,
                        fontsize: 18.0,
                        fontweight: FontWeight.w500,
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
                ), //
                if (cubit.archiveComplaintsAndSuggestions.isEmpty)
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: ScreenSize.height * 0.1,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            child: SvgPicture.asset(
                              "assets/images/nodata.svg",
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextCairo(
                            text: '!سجلك خالٍ من الشكاوى',
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
                                  ' إذا كنت بحاجة إلى المساعدة أو لديك أي ملاحظات، لا تتردد في إرسال شكوى الآن',
                              color: accent_orange,
                              fontsize: 14,
                              fontweight: FontWeight.w400,
                              textalign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 30),
                          Button(
                            onpressed: () {
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
                if (cubit.archiveComplaintsAndSuggestions.isNotEmpty)
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder:
                        (context, index) => buildPostItem(
                          context,
                          cubit.archiveComplaintsAndSuggestions[index],
                        ),
                    separatorBuilder:
                        (context, index) => Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                            vertical: ScreenSize.height * 0.02,
                              horizontal: ScreenSize.width*0.05

                          ),
                          child: Container(height: 1, color: brandColor25),
                        ),
                    itemCount: cubit.archiveComplaintsAndSuggestions.length,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
