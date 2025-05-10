import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/cubit/cubit.dart';
import 'package:damnhour_university/shared/cubit/states.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = UniversityCubit.get(context);
    return BlocConsumer<UniversityCubit, UniversityStates>(
      listener: (BuildContext context, Object? state) {},
      builder:
          (BuildContext context, state) => Scaffold(
            backgroundColor: Colors.white,
            body: cubit.adminscreens[cubit.admincurrentIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 13,
                    spreadRadius: -10,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: cubit.admincurrentIndex,
                onTap: (index) {
                  cubit.adminchangeBottomNav(index);
                },
                items: [
                  _buildNavItem(Icons.person_2_outlined, 'الحساب', 2, cubit),
                  _buildNavItem(
                    Icons.dashboard_outlined,
                    'صفحة التحكم',
                    1,
                    cubit,
                  ),
                  _buildNavItem(Icons.home_outlined, 'الرئيسية', 0, cubit),
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
      icon:
          isSelected
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
      label: label,
    );
  }
}
