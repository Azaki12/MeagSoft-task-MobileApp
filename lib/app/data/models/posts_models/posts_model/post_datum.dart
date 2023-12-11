class PostDatum {
  String? postId;
  String? body;
  DateTime? createdAt;
  String? userId;
  String? fullName;
  List<dynamic>? bookmarkedFrom;
  List<dynamic>? comments;
  int? likes;

  PostDatum({
    this.postId,
    this.body,
    this.createdAt,
    this.userId,
    this.fullName,
    this.bookmarkedFrom,
    this.likes,
    this.comments,
  });

  factory PostDatum.fromJson(Map<String, dynamic> json) => PostDatum(
        postId: json['_id'] as String?,
        body: json['body'] as String?,
        likes: json['likes'] as int?,
        createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
        userId: json['userId'] as String?,
        fullName: json['author'] as String?,
        bookmarkedFrom: json['bookmarkedFrom'] == null ? null : (json['bookmarkedFrom'] as List<dynamic>?),
        comments: json['comments'] == null ? null : (json['comments'] as List<dynamic>?),
      );
}
