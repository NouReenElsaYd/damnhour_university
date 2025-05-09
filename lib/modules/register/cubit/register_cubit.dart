import 'package:damnhour_university/models/register_model.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/network/dio.dart';
import 'package:damnhour_university/shared/network/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' show Color;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:damnhour_university/modules/register/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPasswordVisible = false;
  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(RegisterChangePasswordVisibilityState());
  }

  Color facultyBorderColor = Color.fromRGBO(160, 169, 183, 1);
  String? selectedfaculty;
  bool isFacultyValid = false;
  void changeSelectedfaculty(String? value) {
    selectedfaculty = value;
    emit(facultyChangedState());
  }

  bool validateFaculty() {
    isFacultyValid = selectedfaculty != null;
    if (isFacultyValid) {
      facultyBorderColor = green;
      emit(FacultyValidationState());
      return true;
    } else {
      facultyBorderColor = red;
      emit(FacultyValidationState());
      return false;
    }
  }

  Color adjectiveborder = Color.fromRGBO(160, 169, 183, 1);
  String? selectedadjective;
  bool isAdjectiveValid = false;
  void changeSelectedadjective(String? value) {
    selectedadjective = value;
    emit(adjectiveChangedState());
  }

  bool validateadjective() {
    isAdjectiveValid = selectedadjective != null;
    if (isAdjectiveValid) {
      adjectiveborder = green;
      emit(adjectiveValidationState());
      return true;
    } else {
      adjectiveborder = red;
      emit(adjectiveValidationState());
      return false;
    }
  }

  Color namecolor = Color.fromRGBO(160, 169, 183, 1);
  Color emailcolor = Color.fromRGBO(160, 169, 183, 1);
  Color idcolor = Color.fromRGBO(160, 169, 183, 1);
  Color phonecolor = Color.fromRGBO(160, 169, 183, 1);
  Color passwordcolor = Color.fromRGBO(160, 169, 183, 1);
  Color red = Color.fromRGBO(255, 1, 43, 1);
  Color green = Color.fromARGB(255, 1, 187, 63);
  void validateName(String value) {
    final parts = value.trim().split(RegExp(r'\s+'));
    if (value.isEmpty || parts.length < 3) {
      namecolor = red;
    } else {
      namecolor = green;
    }
    emit(Validationname());
  }

  void validateEmail(String value) {
    if (value.isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      emailcolor = red;
    } else {
      emailcolor = green;
    }
    emit(Validationemail());
  }

  void validateNationalId(String value) {
    if (value.isEmpty || !RegExp(r'^\d{14}$').hasMatch(value)) {
      idcolor = red;
    } else {
      idcolor = green;
    }
    emit(Validationid());
  }

  void validatePhoneNumber(String value) {
    if (value.isEmpty || !RegExp(r'^\d{11}$').hasMatch(value)) {
      phonecolor = red;
    } else {
      phonecolor = green;
    }
    emit(ValidationPhone());
  }

  void validatePassword(String value) {
    if (value.isEmpty ||
        value.length < 8 ||
        !RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(value)) {
      passwordcolor = red;
    } else {
      passwordcolor = green;
    }
    emit(ValidationPassword());
  }

  String errormsgs() {
    if (model?.emailerror == null &&
        model?.usernameerror == null &&
        model?.phoneerror == null) {
      return '${model?.iderror}';
    } else if (model?.iderror == null &&
        model?.usernameerror == null &&
        model?.phoneerror == null) {
      return 'هذا الايميل مسجل بالفعل';
    } else if (model?.iderror == null &&
        model?.emailerror == null &&
        model?.phoneerror == null) {
      return '${model?.usernameerror}';
    } else if (model?.emailerror != null &&
        model?.usernameerror != null &&
        model?.phoneerror != null &&
        model?.iderror != null) {
      return 'هذه البيانات مسجله بالفعل';
    } else if (model?.iderror == null && model?.emailerror == null) {
      return 'رقم الهاتف مسجل بالفعل \n ${model?.usernameerror.toString()}';
    }
    return 'هذه البيانات مسجله بالفعل';
  }

  RegisterModel? model;

  void Register_user({
    required String username,
    required String email,
    required String password,
    required String adjective,
    required bool agree_terms,
    required String faculty,
    required String national_id,
    required String phone,
  }) async {
    emit(registerLoadState());
    await Dio_Helper.PostinDB(
          url: Register,
          data: {
            "username": username,
            "email": email,
            "password": password,
            "adjective": adjective,
            "agree_terms": agree_terms,
            "faculty": faculty,
            "national_id": national_id,
            "phone": phone,
          },
          token: token,
        )
        .then((value) {
          model = RegisterModel.fromJson(value.data);
          // print('response message = ${model!.message}');
          // print('token = ${model!.token}');
          // print('user name = ${model!.usermodel!.username}');
          emit(registerSuccessState(model));
        })
        .catchError((error) {
          error as DioException;

          if (error.response?.data != null &&
              error.response?.data is Map<String, dynamic>) {
            model = RegisterModel.handleerrors(error.response?.data);
            print(model?.usernameerror);
          }

          print('error occur register =${error.toString()}');

          emit(registerErrorState(model));
        });
  }
}
