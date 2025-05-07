import 'package:damnhour_university/models/register_model.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/network/dio.dart';
import 'package:damnhour_university/shared/network/end_points.dart';
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

  String? selectedfaculty;
  void changeSelectedfaculty(String? value) {
    selectedfaculty = value;
    emit(facultyChangedState());
  }

  String? selectedadjective;
  void changeSelectedadjective(String? value) {
    selectedadjective = value;
    emit(adjectiveChangedState());
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
  }) {
    emit(registerLoadState());
    Dio_Helper.PostinDB(
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
          print('register model =${model!.username}');
          emit(registerSuccessState(model));
        })
        .catchError((error) {
          print('error occur register =${error.toString()}');
          emit(registerErrorState());
        });
  }
}
