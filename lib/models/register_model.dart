import 'package:damnhour_university/models/user_model.dart';

class RegisterModel {
  String? message;
  String? token;
  UserModel? usermodel;

  RegisterModel();

  // Factory method to create a RegisterModel from JSON
  RegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    usermodel = UserModel.fromJson(json['user']);
  }

  // Method to convert a RegisterModel to JSON
}
