import 'dart:io';
import 'package:damnhour_university/admin/modules/AdminControl/Admincontrol.dart';
import 'package:damnhour_university/admin/modules/AdminHome/AdminHome.dart';
import 'package:damnhour_university/admin/modules/AdminProfile/AdminProfile.dart';
import 'package:damnhour_university/models/home_model.dart';
import 'package:damnhour_university/models/submit_S_C.dart';
import 'package:damnhour_university/shared/cubit/states.dart';
import 'package:damnhour_university/shared/network/dio.dart';
import 'package:damnhour_university/shared/network/end_points.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../modules/complaints/complaints.dart';
import '../../modules/home/home.dart';
import '../../modules/profile/profile.dart';
import '../../modules/records/records.dart';
import '../components/components.dart';
import '../constants/constants.dart';
import '../styles/colors.dart';

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

  /////////////////////// Complaints Form Methods////////////////////////////
  ///
  ///
  Color sectorcolor = Color.fromRGBO(160, 169, 183, 1);
  bool isSectorValid = false;
  void validatesectoronform(String? value) {
    isSectorValid = selectedSector != null;
    if (!isSectorValid) {
      sectorcolor = Color.fromRGBO(255, 1, 43, 1);
    }
    emit(validatesectoronformState());
  }

  void resetbordercolor() {
    sectorcolor = Color.fromRGBO(160, 169, 183, 1);
    emit(validatesectoronformState());
  }

  String? selectedSector;
  void changeSelectedSector(String? value) {
    selectedSector = value;
    emit(SectorChangedState());
  }

  void resetSelectedSector() {
    selectedSector = null;
    emit(SectorChangedState());
  }

  File? pickedfile;
  void attachFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      pickedfile = File(result.files.single.path!);
      emit(ComplaintsFileAttachedState());
    }
  }

  void resetpickedfile() {
    pickedfile = null;
    emit(ComplaintsFileAttachedState());
  }

  File? pickedimage;
  void attachImage() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      pickedimage = File(image.path);
      print(image.path);

      if (await pickedimage!.exists()) {
        print("Picked image path: ${pickedimage!.path}");
        emit(ComplaintsImageAttachedState());
      } else {
        print("Picked image doesn't exist.");
      }
    }
  }

  Submit_S_C_Model? submitmodel;
  void submitComplaint({
    required String title,
    required String description,
    required String sector,
    required String sc_type,
  }) async {
    final filetoupload = pickedfile ?? pickedimage ?? null;
    emit(ComplaintsSubmitLoadingState());
    FormData formData = FormData.fromMap({
      "title": title,
      "sector": sector,
      "description": description,
      "status": 'معلق',
      'sc_type': sc_type,
      if (filetoupload != null)
        "attachements": await MultipartFile.fromFile(
          filetoupload.path,
          filename: filetoupload.path.split('/').last,
        ),
    });
    await Dio_Helper.PostinDB(
          contenttype: 'multipart/form-data',
          data: formData,
          url: submit_s_c,
          token: 'Bearer ${token}',
        )
        .then((value) {
          if (value.data != null && value.data is Map<String, dynamic>) {
            submitmodel = Submit_S_C_Model.fromJson(value.data);
          } else {
            print("Invalid or null response data: ${value.data}");
            return;
          }
          print(filetoupload?.path);
          emit(ComplaintsSubmitSuccessState(submitmodel?.message));
          resetSelectedSector();
        })
        .catchError((error) {
          if (error is DioException &&
              error.response?.data != null &&
              error.response?.data is Map<String, dynamic>) {
            submitmodel = Submit_S_C_Model.fromJson(error.response?.data);
            print(submitmodel?.codeerror.toString());
          }
          print(error.toString());
          emit(ComplaintsSubmitErrorState(submitmodel?.codeerror.toString()));
        });
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

  //helpCenter

  final List<Map<String, Widget>> helpCenter = [
    {
      'question': Row(
        textDirection: TextDirection.rtl,
        children: [
          SvgPicture.asset(
            'assets/images/Phone.svg',
            width: ScreenSize.width * 0.06,
            height: ScreenSize.width * 0.06,
          ),
          SizedBox(width: ScreenSize.width * 0.026),
          TextCairo(
            text: 'كيف أستخدم التطبيق؟',
            color: primary_blue,
            textalign: TextAlign.start,
          ),
        ],
      ),
      'answer': Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [richTextCairoSteps()],
        ),
      ),
    },
    {
      'question': Row(
        textDirection: TextDirection.rtl,
        children: [
          SvgPicture.asset(
            'assets/images/Tips.svg',
            width: ScreenSize.width * 0.06,
            height: ScreenSize.width * 0.06,
          ),
          SizedBox(width: ScreenSize.width * 0.026),
          TextCairo(
            text: 'نصائح لتقديم شكوى فعالة',
            color: primary_blue,
            textalign: TextAlign.start,
          ),
        ],
      ),
      'answer': Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [richTextCairoSteps()],
        ),
      ),
    },
    {
      'question': Row(
        textDirection: TextDirection.rtl,
        children: [
          SvgPicture.asset(
            'assets/images/Tool.svg',
            width: ScreenSize.width * 0.06,
            height: ScreenSize.width * 0.06,
          ),
          SizedBox(width: ScreenSize.width * 0.026),
          TextCairo(
            text: 'الدعم الفني',
            color: primary_blue,
            textalign: TextAlign.start,
          ),
        ],
      ),
      'answer': Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [supportRichTextCairo()],
        ),
      ),
    },
  ];

  Map<int, bool> expandedTilesHelpCenter = {};

  void toggleTileExpandedHelpCenter(int index) {
    expandedTilesHelpCenter[index] = !(expandedTilesHelpCenter[index] ?? false);
    emit(ChangeArrowTileExpandedState());
  }

  /////////////////////////////////////////ADMIN SECTION/////////////////////////////////////////////

  int admincurrentIndex = 2;
  List<Widget> adminscreens = [AdminProfile(), AdminControl(), AdminHome()];

  void adminchangeBottomNav(int index) {
    admincurrentIndex = index;
    emit(AdminUniversityChangeBottomNavState());
  }

  // Color getcolorstatuscomplaint({String? statusonmodel}) {
  //   if (statusonmodel == 'قيد التنفيذ') {
  //     return brandColor200;
  //   }
  //   return brandColor200;
  // }


  FeedBackModel? feedBackModel;
  void getComplaintsAndSuggestions() {
    emit(GetAllComplaintsAndSuggestionsLoadingState());
    Dio_Helper.getfromDB(url: FEEDBACK,token : 'Bearer $token')
        .then((value) {
          feedBackModel = FeedBackModel.fromJson(value.data);
         // print(feedBackModel);
          emit(GetAllComplaintsAndSuggestionsSuccessState());
        })
        .catchError((error) {
          emit(GetAllComplaintsAndSuggestionsErrorState(error.toString()));
          print('error is : ');
          print(error.toString());
        });
  }

  int sectorIndex=0;
  void changeSectorIndex(int index) {
    sectorIndex = index;
    emit(ChangeSectorIndexState());
  }

}
