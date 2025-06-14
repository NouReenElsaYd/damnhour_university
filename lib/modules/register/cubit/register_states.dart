import 'package:damnhour_university/models/register_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterChangePasswordVisibilityState extends RegisterStates {}

class RegisterChangeCheckboxState extends RegisterStates {}

class RegisterCheckboxValidationState extends RegisterStates {}

class registerSuccessState extends RegisterStates {
  RegisterModel? model;
  registerSuccessState(this.model);
}

class registerErrorState extends RegisterStates {
  RegisterModel? model;
  registerErrorState(this.model);
}

class registerLoadState extends RegisterStates {}

class facultyChangedState extends RegisterStates {}

class adjectiveChangedState extends RegisterStates {}

class Validationname extends RegisterStates {}

class Validationemail extends RegisterStates {}

class Validationid extends RegisterStates {}

class ValidationPhone extends RegisterStates {}

class ValidationPassword extends RegisterStates {}

class FacultyValidationState extends RegisterStates {}

class adjectiveValidationState extends RegisterStates {}

class sectorValidationState extends RegisterStates {}
