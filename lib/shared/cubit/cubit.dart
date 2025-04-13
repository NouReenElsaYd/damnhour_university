import 'package:damnhour_university/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/complaints/complaints.dart';
import '../../modules/home/home.dart';
import '../../modules/profile/help_center/help_center.dart';
import '../../modules/profile/personal_information/personal_information.dart';
import '../../modules/profile/profile.dart';
import '../../modules/profile/protection_safety/protection_safety.dart';
import '../../modules/profile/questions/questions.dart';
import '../../modules/profile/settings/settings.dart';
import '../../modules/records/records.dart';

class UniversityCubit extends Cubit<UniversityStates> {
  UniversityCubit() : super(UniversityInitState());

  static UniversityCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    ProfileScreen(),

    RecordsScreen(),
    ComplaintsScreen(),
    HomeScreen(),
    PersonalInformation(),
    ProtectionSafety(),
    Questions(),
    HelpCenter(),
    Settings()
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(UniversityChangeBottomNavState());
  }


  bool isEnabled = false;
  void changeSwitch(bool value)
  {
    isEnabled=value;
    emit(ChangeSwitchEnabledState());

  }
}
