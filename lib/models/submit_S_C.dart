class Submit_S_C_Model {
  String? message;
  int? complaint_id;
  String? detailerror;
  String? codeerror;

  Submit_S_C_Model();

  // Factory method to create a RegisterModel from JSON
  Submit_S_C_Model.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    complaint_id = json['complaint_id'];
    detailerror = json['detail'];
    codeerror = json['code'];
  }
}
