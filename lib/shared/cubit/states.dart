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

class ComplaintsSubmitSuccessState extends UniversityStates {}

class ComplaintsSubmitErrorState extends UniversityStates {
  var error;
  ComplaintsSubmitErrorState(this.error);
}

//questions
class ChangeArrowTileExpandedState extends UniversityStates {}
