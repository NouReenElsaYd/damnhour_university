import 'package:damnhour_university/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/complaints/complaints.dart';
import '../../modules/home/home.dart';
import '../../modules/profile/profile.dart';
import '../../modules/records/records.dart';

class UniversityCubit extends Cubit<UniversityStates> {
  UniversityCubit() : super(UniversityInitState());

  static UniversityCubit get(context) => BlocProvider.of(context);

  int currentIndex = 3;
  List<Widget> screens = [
    ProfileScreen(),
    RecordsScreen(),
    ComplaintsScreen(),
    HomeScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(UniversityChangeBottomNavState());
  }

  bool isEnabled = false;
  void changeSwitch(bool value) {
    isEnabled = value;
    emit(ChangeSwitchEnabledState());
  }

  // Complaints Form Methods
  String? selectedSector;
  void changeSelectedSector(String? value) {
    selectedSector = value;
    emit(SectorChangedState());
  }

  void attachFile() {
    emit(ComplaintsFileAttachedState());
  }

  void attachImage() {
    emit(ComplaintsImageAttachedState());
  }

  void attachDrawing() {
    emit(ComplaintsDrawingAttachedState());
  }

  void submitComplaint({required String title, required String description}) {
    emit(ComplaintsSubmitLoadingState());

    try {
      emit(ComplaintsSubmitSuccessState());
    } catch (error) {
      emit(ComplaintsSubmitErrorState(error.toString()));
    }
  }

  //questions
  final List<Map<String, String>> questions = [
    {
      'question': 'كيف أقدّم شكوى؟',
      'answer':
      'من الصفحة الرئيسية، اضغط على "تقديم شكوى"، ثم اختر نوع الشكوى واملأ البيانات المطلوبة، واضغط "إرسال".',
    },
    {
      'question': 'هل يمكن تعديل الشكوى بعد إرسالها؟',
      'answer':
      'من الصفحة الرئيسية، اضغط على "تقديم شكوى"، ثم اختر نوع الشكوى واملأ البيانات المطلوبة، واضغط "إرسال".',
    },
    {
      'question': 'متى يتم الرد على الشكوى؟',
      'answer':
      'من الصفحة الرئيسية، اضغط على "تقديم شكوى"، ثم اختر نوع الشكوى واملأ البيانات المطلوبة، واضغط "إرسال".',
    },
    {
      'question': 'كيف أعرف حالة الشكوى؟',
      'answer':
      'من الصفحة الرئيسية، اضغط على "تقديم شكوى"، ثم اختر نوع الشكوى واملأ البيانات المطلوبة، واضغط "إرسال".',
    },
    {
      'question': 'هل يمكنني تقديم شكوى دون الكشف عن هويتي؟',
      'answer':
      'من الصفحة الرئيسية، اضغط على "تقديم شكوى"، ثم اختر نوع الشكوى واملأ البيانات المطلوبة، واضغط "إرسال".',
    },
    {
      'question': 'ماذا أفعل إذا لم يتم حل الشكوى؟',
      'answer':
      'من الصفحة الرئيسية، اضغط على "تقديم شكوى"، ثم اختر نوع الشكوى واملأ البيانات المطلوبة، واضغط "إرسال".',
    },
  ];
  Map<int, bool> expandedTiles = {};

  void toggleTileExpanded(int index) {
    expandedTiles[index] = !(expandedTiles[index] ?? false);
    emit(ChangeArrowTileExpandedState());
  }
}
