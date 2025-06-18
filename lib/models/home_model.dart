import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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
  int? like_count;
  int? dislike_count;
  bool islike = false;
  bool isdislike = false;
  DateTime? createdAtDate;

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
    // ✅ تحويل التاريخ بصيغة dd/MM/yyyy إلى DateTime
    if (created_at != null) {
      try {
        createdAtDate = DateFormat('dd/MM/yyyy').parse(created_at!);
      } catch (e) {
        print('Invalid date format: $created_at');
      }
    }
    like_count = json['like_count'];
    dislike_count = json['dislike_count'];
  }
}

class ItemUserModel {
  String? username;
  String? faculty;
  String? profile_image;
 // late ImageProvider profileImageProvider;

  ItemUserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    faculty = json['faculty'];
  //   if (profile_image != null && profile_image!.isNotEmpty) {
  //     if (profile_image!.startsWith('http')) {
  //       profileImageProvider = NetworkImage(profile_image!);
  //     } else {
  //       profileImageProvider = NetworkImage(
  //         'https://damanhourappproject-production.up.railway.app$profile_image',
  //       );
  //     }
  //   } else {
  //     profileImageProvider = const AssetImage('assets/images/user image1.png');
  //   }
  }
}
