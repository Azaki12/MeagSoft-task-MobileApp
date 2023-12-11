import 'post_datum.dart';
class PostsModel {
  String? status;
  List<PostDatum>? data;

  PostsModel({this.status, this.data});

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
        status: json['status'] as String?,
        data: json['data'] == null
            ? null
            : (json['data'] as List<dynamic>?)
                ?.map((e) => PostDatum.fromJson(e as Map<String, dynamic>))
                .toList(),
      );
}
