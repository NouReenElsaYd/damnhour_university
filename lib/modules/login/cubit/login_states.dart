import 'package:damnhour_university/models/resetpass_models.dart';
import 'package:damnhour_university/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangePasswordVisibilityState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel model;
  LoginSuccessState(this.model);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class forgetpassLoadingState extends LoginStates {}

class forgetpassSuccessState extends LoginStates {
  final ForgetpassModel model;
  forgetpassSuccessState(this.model);
}

class forgetpassErrorState extends LoginStates {
  final String error;
  forgetpassErrorState(this.error);
}

class EmailSavedState extends LoginStates {}

class OTPLoadingState extends LoginStates {}

class OTPSuccessState extends LoginStates {
  final OTPModel model;
  OTPSuccessState(this.model);
}

class OTPErrorState extends LoginStates {
  final String error;
  OTPErrorState(this.error);
}

class ResetPassLoadingState extends LoginStates {}

class ResetPassSuccessState extends LoginStates {
  final ResetPassModel model;
  ResetPassSuccessState(this.model);
}

class ResetPassErrorState extends LoginStates {
  final String error;
  ResetPassErrorState(this.error);
}

class checkispassmatchState extends LoginStates {}
