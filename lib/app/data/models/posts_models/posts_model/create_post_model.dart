import 'post_datum.dart';

class CreatePostModel {
  String? status;
  PostDatum? data;

  CreatePostModel({this.status, this.data});

  factory CreatePostModel.fromJson(Map<String, dynamic> json) => CreatePostModel(
        status: json['status'] as String?,
        data: json['data'] == null ? null : PostDatum.fromJson(json['data'] as Map<String, dynamic>),
      );
}
