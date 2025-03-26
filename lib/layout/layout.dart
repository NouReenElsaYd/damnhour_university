import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/constants/constants.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
import '../shared/styles/colors.dart';

class LayoutScreen extends StatelessWidget {
  LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = UniversityCubit.get(context);
    return BlocConsumer<UniversityCubit, UniversityStates>(
      listener: (BuildContext context, Object? state) {},
      builder:
          (BuildContext context, state) => Scaffold(
        backgroundColor: Colors.white,
        //appBar: AppBar(),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(  // for making elevation that is in the bottomNavBat
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey, // Stronger shadow
                blurRadius: 13, //  more spread shadow
                spreadRadius: -10, // Makes shadow more visible
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {

              cubit.changeBottomNav(index);
            },
            items: [
              _buildNavItem(Icons.person_2_outlined, 'الحساب', 0, cubit),
              _buildNavItem(Icons.history, 'السجل', 1, cubit),
              _buildNavItem(Icons.article_outlined, 'الشكاوي', 2, cubit),
              _buildNavItem(Icons.home_outlined, 'الرئيسية', 3, cubit),
            ],
            selectedItemColor: primary_blue,
            unselectedItemColor: primary_blue,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon,
      String label,
      int index,
      UniversityCubit cubit,
      ) {
    bool isSelected = index == cubit.currentIndex;

    return BottomNavigationBarItem(
      icon: isSelected
          ? Container(
        width: ScreenSize.width * 0.16,
        height: ScreenSize.height * 0.045,
        padding: EdgeInsets.symmetric(
          vertical: ScreenSize.height * 0.01,
          horizontal: ScreenSize.width * 0.04,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: brandColor25,
        ),
        child: Icon(icon, color: primary_blue),
      )
          : Icon(icon, color: primary_blue),
      label: label, // if i put any label the string will duplicate
    );
  }

}
