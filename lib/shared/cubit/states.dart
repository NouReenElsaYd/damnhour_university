class UniversityStates {}

class UniversityInitState extends UniversityStates {}

class UniversityChangeBottomNavState extends UniversityStates {}

class AdminUniversityChangeBottomNavState extends UniversityStates {}

class ChangeSwitchEnabledState extends UniversityStates {}

// Complaints Form States
class SectorChangedState extends UniversityStates {}

class ComplaintsFileAttachedState extends UniversityStates {}

class ComplaintsImageAttachedState extends UniversityStates {}

class ComplaintsDrawingAttachedState extends UniversityStates {}

class ComplaintsSubmitLoadingState extends UniversityStates {}

class ComplaintsSubmitSuccessState extends UniversityStates {
  var message;
  ComplaintsSubmitSuccessState(this.message);
}

class ComplaintsSubmitErrorState extends UniversityStates {
  var error;
  ComplaintsSubmitErrorState(this.error);
}

//questions
class ChangeArrowTileExpandedState extends UniversityStates {}

class validatesectoronformState extends UniversityStates {}

class getprofileinfoLoadingState extends UniversityStates {}

class getprofileinfoSuccessState extends UniversityStates {
  var message;
  getprofileinfoSuccessState(this.message);
}

class getprofileinfoErrorState extends UniversityStates {
  var error;
  getprofileinfoErrorState(this.error);
}
