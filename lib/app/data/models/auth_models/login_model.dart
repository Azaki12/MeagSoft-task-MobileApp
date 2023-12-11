import 'login_datum.dart';

class LoginResponseModel {
  String? status;
  String? token;
  LoginDatum? data;

  LoginResponseModel({this.status, this.data, this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'] as String?,
      data: json['data'] == null ? null : LoginDatum.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );
  }
}
