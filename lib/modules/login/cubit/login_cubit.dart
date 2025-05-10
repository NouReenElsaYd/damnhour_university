import 'package:damnhour_university/models/resetpass_models.dart';
import 'package:damnhour_university/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:damnhour_university/modules/login/cubit/login_states.dart';
import 'package:damnhour_university/models/login_model.dart';
import 'package:damnhour_university/shared/network/dio.dart';
import 'package:damnhour_university/shared/network/end_points.dart';
import 'package:dio/dio.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPasswordVisible = false;

  LoginModel? model;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginChangePasswordVisibilityState());
  }

  void userLogin({required String email, required String password}) async {
    emit(LoginLoadingState());
    await Dio_Helper.PostinDB(
          url: Login, // your login endpoint
          data: {"email": email, "password": password},
        )
        .then((value) {
          model = LoginModel.fromJson(value.data);
          print(model?.user?.position);
          emit(LoginSuccessState(model!));
        })
        .catchError((error) {
          error as DioException;
          if (error.response?.data != null &&
              error.response?.data is Map<String, dynamic>) {
            model = LoginModel.handleError(error.response?.data);
            emit(LoginErrorState(model?.error ?? " خطأ في الانترنت "));
          } else {
            emit(LoginErrorState(" خطأ في الانترنت "));
          }
        });
  }
  ////////////////////////////////////FORGET PASSWORD PAGE//////////////////////////////////////////

  ForgetpassModel? forgetpassmodel;
  void forgetpass({required String? email}) async {
    emit(forgetpassLoadingState());
    await Dio_Helper.PostinDB(url: forget_pass, data: {"email": email})
        .then((value) {
          forgetpassmodel = ForgetpassModel.fromJson(value.data);
          emit(forgetpassSuccessState(forgetpassmodel!));
        })
        .catchError((error) {
          error as DioException;
          if (error.response?.data != null &&
              error.response?.data is Map<String, dynamic>) {
            forgetpassmodel = ForgetpassModel.handleerrors(
              error.response?.data,
            );
            print(error.toString());
            print(forgetpassmodel?.error);
            emit(
              forgetpassErrorState(
                forgetpassmodel?.error ?? " خطأ في الانترنت ",
              ),
            );
          } else {
            emit(forgetpassErrorState(" خطأ في الانترنت "));
          }
        });
  }

  ////////////////////////////////////OTP Handle//////////////////////////////////////////////
  String? savedemail;
  void saveemail({required String email}) {
    savedemail = email;
    print(savedemail);
    emit(EmailSavedState());
  }

  OTPModel? otpmodel;
  void verifyOTP({required String? email, required String otp}) async {
    emit(OTPLoadingState());
    await Dio_Helper.PostinDB(url: Otp, data: {"email": email, "otp": otp})
        .then((value) {
          otpmodel = OTPModel.fromJson(value.data);
          emit(OTPSuccessState(otpmodel!));
        })
        .catchError((error) {
          error as DioException;
          if (error.response?.data != null &&
              error.response?.data is Map<String, dynamic>) {
            otpmodel = OTPModel.fromJson(error.response?.data);
          }
          print(error.toString());
          print(otpmodel?.error);
          emit(OTPErrorState(otpmodel?.error ?? " خطأ في الانترنت "));
        });
  }

  ////////////////////////////////////////HANDLE RESET-PASSWORD/////////////////////////////////////////////
  ///
  bool checkispassmatch({
    required String confirmpass,
    required String newpass,
  }) {
    if (confirmpass != newpass) {
      showtoast(message: 'كلمه المرور غير متطابقه', color: Colors.red);
      emit(checkispassmatchState());
      return false;
    } else {
      emit(checkispassmatchState());
      return true;
    }
  }

  ResetPassModel? resetpassmodel;
  void resetpassword({
    required String? email,
    required String? new_password,
    required String? confirm_password,
  }) async {
    emit(ResetPassLoadingState());
    await Dio_Helper.PostinDB(
          url: ResetPass,
          data: {
            "email": email,
            "new_password": new_password,
            "confirm_password": confirm_password,
          },
        )
        .then((value) {
          resetpassmodel = ResetPassModel.fromJson(value.data);
          emit(ResetPassSuccessState(resetpassmodel!));
        })
        .catchError((error) {
          error as DioException;
          if (error.response?.data != null &&
              error.response?.data is Map<String, dynamic>) {
            resetpassmodel = ResetPassModel.fromJson(error.response?.data);
          }
          print(error.toString());
          print(resetpassmodel?.error);
          emit(ResetPassErrorState(resetpassmodel?.error ?? "خطأ في الانترنت"));
        });
  }
}
