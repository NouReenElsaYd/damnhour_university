class UserModel {
  int? id;
  String? username;
  String? email;
  String? phone;
  String? faculty;
  String? position;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.faculty,
    required this.position,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    faculty = json['faculty'];
    position = json['position'] ?? 'مستخدم';
  }
}
