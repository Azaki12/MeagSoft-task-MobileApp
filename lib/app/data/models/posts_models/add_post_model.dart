class AddPostModel {
  String? body;
  String? author;
  String? id;

  AddPostModel({this.body, this.author, this.id});
  Map<String, dynamic> toJson() => {
        'body': body,
        'author': author,
        'userId': id,
      };
}
