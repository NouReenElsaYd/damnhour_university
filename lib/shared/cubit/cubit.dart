import 'dart:io';
import 'package:damnhour_university/admin/modules/AdminControl/Admincontrol.dart';
import 'package:damnhour_university/admin/modules/AdminHome/AdminHome.dart';
import 'package:damnhour_university/admin/modules/AdminProfile/AdminProfile.dart';
import 'package:damnhour_university/models/home_model.dart';
import 'package:damnhour_university/models/getprofile_info.dart';
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
        "attachments": await MultipartFile.fromFile(
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

  //////////////////////////////////////////GET PROFILE INFO/////////////////////////////////////////
  GetProfileModel? profilemodel;
  void getprofileinfo() {
    emit(getprofileinfoLoadingState());
    Dio_Helper.getfromDB(url: getprofile, token: 'Bearer ${token}')
        .then((value) {
          profilemodel = GetProfileModel.fromjson(value.data);
          emit(getprofileinfoSuccessState(profilemodel?.message));
          print(profilemodel?.message);
          forprofileadmin();
        })
        .catchError((error) {
          emit(getprofileinfoErrorState(error));
          print(error.toString());
        });
  }

  /////////////////////////////////////////ADMIN SECTION/////////////////////////////////////////////

  int admincurrentIndex = 2;
  List<Widget> adminscreens = [AdminProfile(), AdminControl(), AdminHome()];

  void adminchangeBottomNav(int index) {
    admincurrentIndex = index;
    if (admincurrentIndex == 0) {
      getprofileinfo();
    } else if (admincurrentIndex == 2) {
      getComplaintsAndSuggestions();
    }
    emit(AdminUniversityChangeBottomNavState());
  }

  updateComplaintModel? updates_c_model;
  void updateS_C({
    required String id,
    String? response,
    String? status,
    required String? type_S_C,
  }) async {
    emit(updateS_CLoadingState());
    await Dio_Helper.updateDB(
          data: {'status': status, 'response': response},
          url: type_S_C == 'شكوى' ? 'complaint/${id}/' : 'suggestion/${id}/',
          token: 'Bearer ${token}',
        )
        .then((value) {
          if (value.data != null && value.data is Map<String, dynamic>) {
            updates_c_model = updateComplaintModel.fromJson(value.data);
          } else {
            print("Invalid or null response data: ${value.data}");
            return;
          }
          emit(updateS_CSuccessState(updates_c_model?.message));
        })
        .catchError((error) {
          updates_c_model = updateComplaintModel.fromJson(error.response?.data);
          // print(updates_c_model?.codeerror.toString());
          print('${status}   ${response}    ${id}');
          print(error.toString());
          emit(updateS_CErrorState(updates_c_model?.codeerror.toString()));
        });
  }

  String? selectedstatus;
  void changeselectedstatus(String? value) {
    selectedstatus = value;
    emit(statusChangedState());
  }

  void resetselectedstatus() {
    selectedstatus = null;
    statusBorderColor = Color.fromRGBO(160, 169, 183, 1);
    emit(statusChangedState());
  }

  bool isStatusValid = false;
  Color statusBorderColor = Color.fromRGBO(160, 169, 183, 1);
  bool validateStatus() {
    isStatusValid = selectedstatus != null;
    if (isStatusValid) {
      statusBorderColor = Color.fromARGB(255, 1, 187, 63);
      ;
      emit(validateStatusState());
      return true;
    } else {
      statusBorderColor = Color.fromRGBO(255, 1, 43, 1);
      ;
      emit(validateStatusState());
      return false;
    }
  }

  deleteS_CModel? deleteModel;
  void deleteS_C({required String id, required String? type_S_C}) {
    emit(deleteS_CLoadingState());
    Dio_Helper.delete(
          url: type_S_C == 'شكوى' ? 'complaint/${id}/' : 'suggestion/${id}/',
          token: 'Bearer ${token}',
        )
        .then((value) {
          emit(deleteS_CSuccessState());
        })
        .catchError((error) {
          if (error is DioException)
            deleteModel = deleteS_CModel.fromJson(error.response?.data);
          print(error.toString());
          emit(
            deleteS_CErrorState(deleteModel?.codeerror ?? deleteModel?.message),
          );
        });
  }

  // Color getcolorstatuscomplaint({String? statusonmodel}) {
  //   if (statusonmodel == 'قيد التنفيذ') {
  //     return brandColor200;
  //   }
  //   return brandColor200;
  // }

  List<ItemModel> allPosts = [];
  List<ItemModel> filteredPosts = [];
  FeedBackModel? feedBackModel;
  void getComplaintsAndSuggestions() {
    emit(GetAllComplaintsAndSuggestionsLoadingState());

    Dio_Helper.getfromDB(url: FEEDBACK, token: 'Bearer $token')
        .then((value) {
          feedBackModel = FeedBackModel.fromJson(value.data);
          allPosts = feedBackModel?.data ?? [];
          filteredPosts = allPosts;
          filteredPostsbystatus = filteredPosts; // في البداية الكل
          emit(GetAllComplaintsAndSuggestionsSuccessState());
        })
        .catchError((error) {
          emit(GetAllComplaintsAndSuggestionsErrorState(error.toString()));
          print('error is : ');
          print(error.toString());
        });
  }

  void filterPostsBySector(String sectorName) {
    if (sectorName == 'الكل') {
      filteredPosts = allPosts;
      filteredPostsbystatus = filteredPosts;
    } else {
      filteredPosts =
          allPosts.where((post) => post.sector == sectorName).toList();
      filteredPostsbystatus =
          allPosts.where((post) => post.sector == sectorName).toList();
    }
    emit(FilterBySectorChangedState());
  }

  //ليست متفلتره قطاعات و الحاله
  List<ItemModel> filteredPostsbystatus = [];
  String? searchId;
  void updateSearchId(String? value) {
    searchId = value;
    filterPostsBySectorandstatus();
  }

  void filterPostsBySectorandstatus({String? status = ''}) {
    if (status != null && status.isNotEmpty) {
      filteredPostsbystatus =
          filteredPosts.where((post) => post.status == status).toList();
    } else if (status == null || searchId != null) {
      filteredPostsbystatus =
          allPosts
              .where((post) => post.id.toString().contains(searchId!))
              .toList();
    }
    emit(FilterBySectorChangedState());
  }

  ///////////////////for profile admin///////////////
  List<ItemModel> repliedS_C = [];
  List<ItemModel> pendingS_C = [];
  void forprofileadmin() {
    pendingS_C = allPosts.where((post) => post.status == 'معلق').toList();
    repliedS_C = allPosts.where((post) => post.status == 'تم الحل').toList();
    emit(ForprofileadminChangedState());
  }

  ///////////////////////////////////////////////////////
  int sectorIndex = 0;
  void changeSectorIndex(int index) {
    sectorIndex = index;
    emit(ChangeSectorIndexState());
  }
}
