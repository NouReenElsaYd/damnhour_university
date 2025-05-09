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
          emit(LoginSuccessState(model!));
        })
        .catchError((error) {
          error as DioException;
          if (error.response?.data != null &&
              error.response?.data is Map<String, dynamic>) {
            model = LoginModel.handleError(error.response?.data);
            emit(LoginErrorState(model?.error ?? "حدث خطأ غير متوقع"));
          } else {
            emit(LoginErrorState("حدث خطأ غير متوقع"));
          }
        });
  }
}
