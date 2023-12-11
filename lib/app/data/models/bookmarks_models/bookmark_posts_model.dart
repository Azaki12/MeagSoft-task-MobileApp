import 'package:test_app/app/data/models/posts_models/posts_model/post_datum.dart';

class BookmarkPostsModel {
  String? status;

  List<BookmarkPostsDatum>? data;

  BookmarkPostsModel({this.status, this.data});

  factory BookmarkPostsModel.fromJson(Map<String, dynamic> json) {
    return BookmarkPostsModel(
      status: json['status'] as String?,
      data: json['data'] == null ? null : (json['data'] as List<dynamic>?)?.map((e) => BookmarkPostsDatum.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}

class BookmarkPostsDatum {
  String? id;
  List<dynamic>? userIDs;
  PostDatum? post;

  BookmarkPostsDatum({
    this.id,
    this.userIDs,
    this.post,
  });

  factory BookmarkPostsDatum.fromJson(Map<String, dynamic> json) => BookmarkPostsDatum(
        id: json['_id'] as String?,
        userIDs: json['userIDs'] == null ? null : (json['userIDs'] as List<dynamic>?),
        post: json['post'] == null ? null : PostDatum.fromJson(json['post'] as Map<String, dynamic>),
      );
}
