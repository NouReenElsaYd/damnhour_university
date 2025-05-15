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

//get all complaints and suggestions (feedBack)
class GetAllComplaintsAndSuggestionsLoadingState extends UniversityStates {}
class GetAllComplaintsAndSuggestionsSuccessState extends UniversityStates {}
class GetAllComplaintsAndSuggestionsErrorState extends UniversityStates {
  var error;
  GetAllComplaintsAndSuggestionsErrorState(this.error);
}

class FilterBySectorChangedState extends UniversityStates {}

class ChangeSectorIndexState extends UniversityStates {}



class getprofileinfoLoadingState extends UniversityStates {}

class getprofileinfoSuccessState extends UniversityStates {
  var message;
  getprofileinfoSuccessState(this.message);
}

class getprofileinfoErrorState extends UniversityStates {
  var error;
  getprofileinfoErrorState(this.error);
}

class updateS_CLoadingState extends UniversityStates {}

class updateS_CSuccessState extends UniversityStates {
  var message;
  updateS_CSuccessState(this.message);
}

class updateS_CErrorState extends UniversityStates {
  var error;
  updateS_CErrorState(this.error);
}

class statusChangedState extends UniversityStates {}

class validateStatusState extends UniversityStates {}

class deleteS_CLoadingState extends UniversityStates {}

class deleteS_CSuccessState extends UniversityStates {}

class deleteS_CErrorState extends UniversityStates {
  var error;
  deleteS_CErrorState(this.error);
}
