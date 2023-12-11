class CreateBookmarkModel {
  CreateBookmarkModel({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  factory CreateBookmarkModel.fromJson(Map<String, dynamic> json) {
    return CreateBookmarkModel(
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.id,
    required this.userIds,
    required this.post,
  });

  final String? id;
  final List<String>? userIds;
  final String? post;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["_id"],
      userIds: json["userIds"],
      post: json["post"],
    );
  }
}
