// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CommentModel {
  String? userId;
  String? postId;
  
  CommentModel({
    this.userId,
    this.postId,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      userId: map['userId'] != null ? map['userId'] as String : null,
      postId: map['postId'] != null ? map['postId'] as String : null,
    );
  }

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
