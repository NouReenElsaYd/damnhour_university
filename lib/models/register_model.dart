import 'package:damnhour_university/models/user_model.dart';

class RegisterModel {
  String? message;
  String? token;
  UserModel? usermodel;
  String? usernameerror;
  String? iderror;
  String? emailerror;
  String? phoneerror;


  RegisterModel();

  // Factory method to create a RegisterModel from JSON
  RegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    usermodel = UserModel.fromJson(json['user']);
  }

  RegisterModel.handleerrors(Map<String, dynamic> errors) {
    usernameerror = errors['username'] != null ? errors['username'][0] : null;
    iderror = errors['national_id'] != null ? errors['national_id'][0] : null;
    emailerror = errors['email'] != null ? errors['email'][0] : null;
    phoneerror = errors['phone'] != null ? errors['phone'][0] : null;
  }
}
