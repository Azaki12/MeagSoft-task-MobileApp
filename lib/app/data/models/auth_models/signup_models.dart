class SignupRequestModel {
  String? email;
  String? password;
  String? fullName;
  String? passwordConfirm;

  SignupRequestModel({
    this.email,
    this.password,
    this.fullName,
    this.passwordConfirm,
  });
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': fullName,
        'passwordConfirm': passwordConfirm,
      };
}
