class RegisterModel {
  String? username;
  String? email;
  String? password;
  String? adjective;
  String? national_id;
  String? phone;
  String? faculty;
  bool? agree_terms;

  RegisterModel({
    required this.username,
    required this.email,
    required this.password,
    required this.adjective,
    required this.agree_terms,
    required this.faculty,
    required this.national_id,
    required this.phone,
  });

  // Factory method to create a RegisterModel from JSON
  RegisterModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    faculty = json['faculty'];
  }

  // Method to convert a RegisterModel to JSON
  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "adjective": adjective,
      "agree_terms": agree_terms,
      "faculty": faculty,
      "national_id": national_id,
      "phone": phone,
    };
  }
}
