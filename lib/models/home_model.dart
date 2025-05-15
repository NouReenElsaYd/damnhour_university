class FeedBackModel {
  String? sector;
  String? sc_type;
  String? message;
  List<ItemModel> data = [];

  FeedBackModel.fromJson(Map<String, dynamic> json) {
    sector = json['sector'];
    sc_type = json['sc_type'];
    message = json['message'];

    json['data'].forEach((e) {
      ItemModel item = ItemModel.fromJson(e);
      data.add(item);
    });
  }
}

class ItemModel {
  int? id;
  ItemUserModel? user;
  String? title;
  String? sector;
  String? description;
  String? attachments;
  String? status;
  String? sc_type;
  String? response;
  String? created_at;

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? ItemUserModel.fromJson(json['user']) : null;
    title = json['title'];
    sector = json['sector'];
    description = json['description'];
    attachments = json['attachments'];
    status = json['status'];
    sc_type = json['sc_type'];
    response = json['response'];
    created_at = json['created_at'];
  }
}

class ItemUserModel {
  String? username;
  String? faculty;

  ItemUserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    faculty = json['faculty'];
  }
}
