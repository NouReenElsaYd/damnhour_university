import 'package:damnhour_university/models/register_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterChangePasswordVisibilityState extends RegisterStates {}

class registerSuccessState extends RegisterStates {
  RegisterModel? model;
  registerSuccessState(this.model);
}

class registerErrorState extends RegisterStates {}

class registerLoadState extends RegisterStates {}

class facultyChangedState extends RegisterStates {}

class adjectiveChangedState extends RegisterStates {}
