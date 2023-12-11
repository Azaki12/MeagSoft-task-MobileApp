import 'data.dart';

class ProfileModel {
  String? status;
  ProfileData? data;

  ProfileModel({this.status, this.data});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json['status'] as String?,
      data: json['data'] == null ? null : ProfileData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
