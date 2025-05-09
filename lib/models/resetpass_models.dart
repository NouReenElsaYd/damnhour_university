class ForgetpassModel {
  String? error;
  String? message;

  ForgetpassModel();

  // Factory method to create a RegisterModel from JSON
  ForgetpassModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  ForgetpassModel.handleerrors(Map<String, dynamic> errors) {
    error = errors['error'] != null ? errors['error'] : null;
  }
}

class OTPModel {
  String? error;
  String? message;

  OTPModel({this.error, this.message});

  OTPModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
  }
}

class ResetPassModel {
  String? error;
  String? message;

  ResetPassModel({this.error, this.message});

  ResetPassModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
  }
}
