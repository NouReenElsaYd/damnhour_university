class GetProfileModel {
  String? message;
  String? username;
  String? email;
  String? phone;
  String? faculty;
  String? adjective;
  GetProfileModel.fromjson(Map<String, dynamic> json) {
    message = json['message'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    faculty = json['faculty'];
    adjective = json['adjective'];
  }
}
