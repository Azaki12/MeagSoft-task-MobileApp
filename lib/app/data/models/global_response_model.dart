class GlobalResponseModel {
  String? status;
  int? code;

  GlobalResponseModel({this.status, this.code});

  factory GlobalResponseModel.fromJson(Map<String, dynamic> json) {
    return GlobalResponseModel(
      status: json['status'] as String?,
      code: json['code'] as int?,
    );
  }
}
